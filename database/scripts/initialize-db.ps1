$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"

if (-not (Test-Path $envPath)) {
    throw ".env が見つかりません。.env.example をコピーして値を設定してください。"
}

Get-Content $envPath | ForEach-Object {
    if ($_ -match '^\s*([^#][^=]*)=(.*)$') {
        [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
    }
}

$databaseName = $env:MSSQL_DATABASE
$appLogin = $env:MSSQL_APP_LOGIN
$appPassword = $env:MSSQL_APP_PASSWORD
$saPassword = $env:MSSQL_SA_PASSWORD

if ([string]::IsNullOrWhiteSpace($databaseName) -or
    [string]::IsNullOrWhiteSpace($appLogin) -or
    [string]::IsNullOrWhiteSpace($appPassword) -or
    [string]::IsNullOrWhiteSpace($saPassword)) {
    throw ".env の必須項目が不足しています。"
}

& (Join-Path $PSScriptRoot "start-db.ps1")

Write-Host "SQL Server の起動完了を待機しています..."
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
    docker exec horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $saPassword -C -Q "SELECT 1" 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $ready = $true
        break
    }
    Start-Sleep -Seconds 2
}

if (-not $ready) {
    throw "SQL Server が起動状態になりませんでした。docker logs horse-racing-sqlserver を確認してください。"
}

function Invoke-SqlFile {
    param([Parameter(Mandatory = $true)][string] $Path)

    Write-Host "実行: $Path"
    Get-Content $Path -Raw | docker exec -i horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $saPassword -C -b -v DatabaseName="$databaseName" AppLogin="$appLogin" AppPassword="$appPassword"
    if ($LASTEXITCODE -ne 0) {
        throw "SQL実行に失敗しました: $Path"
    }
}

Invoke-SqlFile (Join-Path $repoRoot "database/ddl/001_create_database.sql")
Invoke-SqlFile (Join-Path $repoRoot "database/ddl/005_create_app_user.sql")
Invoke-SqlFile (Join-Path $repoRoot "database/ddl/010_schema_placeholder.sql")
Invoke-SqlFile (Join-Path $repoRoot "database/seed/100_seed_master_data.sql")

Write-Host "DB初期化が完了しました。"
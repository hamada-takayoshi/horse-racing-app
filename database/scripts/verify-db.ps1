$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"

if (-not (Test-Path $envPath)) { throw ".env が見つかりません。" }

Get-Content $envPath | ForEach-Object {
    if ($_ -match '^\s*([^#][^=]*)=(.*)$') {
        [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), "Process")
    }
}

$databaseName = $env:MSSQL_DATABASE
$appLogin = $env:MSSQL_APP_LOGIN
$appPassword = $env:MSSQL_APP_PASSWORD

docker exec horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U $appLogin -P $appPassword -C -d $databaseName -b -Q "SELECT DB_NAME() AS DatabaseName, SUSER_SNAME() AS LoginName, SYSUTCDATETIME() AS VerifiedAtUtc;"
if ($LASTEXITCODE -ne 0) { throw "アプリ用ユーザーでのDB接続確認に失敗しました。" }

Write-Host "DB接続確認に成功しました。"
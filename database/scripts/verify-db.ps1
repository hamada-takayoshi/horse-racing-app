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
$schemaValidationPath = Join-Path $repoRoot "database/ddl/900_verify_schema.sql"

docker exec horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U $appLogin -P $appPassword -C -d $databaseName -b -Q "SELECT DB_NAME() AS DatabaseName, SUSER_SNAME() AS LoginName, SYSUTCDATETIME() AS VerifiedAtUtc;"
if ($LASTEXITCODE -ne 0) { throw "アプリ用ユーザーでのDB接続確認に失敗しました。" }

Get-Content $schemaValidationPath -Raw | docker exec -i horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U $appLogin -P $appPassword -C -d $databaseName -b -v DatabaseName="$databaseName"
if ($LASTEXITCODE -ne 0) { throw "アプリ用ユーザーでのDBスキーマ確認に失敗しました。" }

docker exec horse-racing-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U $appLogin -P $appPassword -C -d $databaseName -b -Q "SET XACT_ABORT ON; BEGIN TRANSACTION; INSERT INTO dbo.RacingCategory (RacingCategoryCode, RacingCategoryName, SortOrder, IsActive) VALUES ('VERIFY_WRITE', N'書込み検証', 32767, 0); ROLLBACK TRANSACTION;"
if ($LASTEXITCODE -ne 0) { throw "アプリ用ユーザーでのDB書込み確認に失敗しました。" }

Write-Host "DB接続・スキーマ・読書き権限の確認に成功しました。"

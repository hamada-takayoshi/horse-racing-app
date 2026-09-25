$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"
$composePath = Join-Path $repoRoot "docker/compose.yml"

if (-not (Test-Path $envPath)) {
    throw ".env が見つかりません。"
}

docker compose --env-file $envPath -f $composePath down
if ($LASTEXITCODE -ne 0) {
    throw "SQL Server コンテナの停止に失敗しました。"
}

Write-Host "SQL Server コンテナを停止しました。データVolumeは保持されています。"
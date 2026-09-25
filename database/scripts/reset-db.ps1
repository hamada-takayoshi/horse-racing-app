$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"
$composePath = Join-Path $repoRoot "docker/compose.yml"

if (-not (Test-Path $envPath)) { throw ".env が見つかりません。" }

$confirmation = Read-Host "DBデータを含むDocker Volumeを削除します。実行する場合は RESET と入力してください"
if ($confirmation -ne "RESET") {
    Write-Host "キャンセルしました。"
    exit 0
}

docker compose --env-file $envPath -f $composePath down -v
if ($LASTEXITCODE -ne 0) { throw "DBリセットに失敗しました。" }

Write-Host "SQL ServerコンテナとDBデータVolumeを削除しました。"
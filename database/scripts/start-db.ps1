$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"
$composePath = Join-Path $repoRoot "docker/compose.yml"

if (-not (Test-Path $envPath)) {
    throw ".env が見つかりません。.env.example をコピーして値を設定してください。"
}

docker compose --env-file $envPath -f $composePath up -d
if ($LASTEXITCODE -ne 0) {
    throw "SQL Server コンテナの起動に失敗しました。"
}

Write-Host "SQL Server コンテナを起動しました。"
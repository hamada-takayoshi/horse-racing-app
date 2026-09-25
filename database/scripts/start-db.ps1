$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")
$envPath = Join-Path $repoRoot ".env"
$composePath = Join-Path $repoRoot "docker/compose.yml"

if (-not (Test-Path $envPath)) {
    throw ".env was not found. Copy .env.example to .env and configure the values."
}

docker compose --env-file $envPath -f $composePath up -d
if ($LASTEXITCODE -ne 0) {
    throw "Failed to start the SQL Server container."
}

Write-Host "SQL Server container started."
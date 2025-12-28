# Canary Deployment Traffic Test Script
# Sends 100 requests and counts responses from each version

Write-Host "========================================"
Write-Host "  Canary Deployment Traffic Test"
Write-Host "========================================"
Write-Host "Sending 100 requests to http://localhost..."
Write-Host ""

$stable = 0
$canary = 0

for ($i = 1; $i -le 100; $i++) {
    $response = Invoke-WebRequest -Uri "http://localhost" -UseBasicParsing
    if ($response.Content -match "STABLE") {
        $stable++
    } elseif ($response.Content -match "CANARY") {
        $canary++
    }
    Write-Progress -Activity "Testing Canary Deployment" -Status "Request $i of 100" -PercentComplete $i
}

Write-Host ""
Write-Host "========================================"
Write-Host "  Results"
Write-Host "========================================"
Write-Host "  V1 (Stable): $stable requests ($stable%)"
Write-Host "  V2 (Canary): $canary requests ($canary%)"
Write-Host "========================================"
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "  Executando Testes com Robot Framework e Allure" -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

robot --listener "allure_robotframework;results/allure-results" -d results tests/

Write-Host "`n===================================================" -ForegroundColor Green
Write-Host "  Gerando e exibindo relatorio Allure..." -ForegroundColor Green
Write-Host "===================================================" -ForegroundColor Green

allure serve results/allure-results


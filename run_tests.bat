@echo off
echo ===================================================
echo   Executando Testes com Robot Framework e Allure
echo ===================================================

robot --listener "allure_robotframework;results/allure-results" -d results tests/

echo.
echo ===================================================
echo   Gerando e exibindo relatorio Allure...
echo ===================================================
allure serve results/allure-results


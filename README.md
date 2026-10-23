# Projeto Robot Framework - Automação Web

Testes automatizados com Robot Framework, SeleniumLibrary e relatórios com Allure.

## 🚀 Pré-requisitos

1. **Python 3.10+**
2. **Dependências Python**:
   ```bash
   pip install -r requirements.txt
   ```
3. **Allure CLI** (necessário para gerar e abrir o painel HTML do Allure no Windows):
   - Via Scoop:
     ```bash
     scoop install allure
     ```
   - Ou via Chocolatey:
     ```bash
     choco install allure-commandline
     ```
   - Ou via NPM:
     ```bash
     npm install -g allure-commandline
     ```

---

## 🧪 Execução dos Testes e Geração do Allure

### Opção 1: Script Automático
Execute o arquivo batch:
```bash
.\run_tests.bat
```
*(ou `.\run_tests.ps1` no PowerShell)*

### Opção 2: Manualmente via Terminal

1. **Executar os testes gerando os resultados do Allure e do Robot**:
   ```bash
   robot --listener "allure_robotframework;results/allure-results" -d results tests/
   ```

2. **Abrir o relatório interativo do Allure**:
   ```bash
   allure serve results/allure-results
   ```

3. **(Opcional) Gerar relatório estático em HTML**:
   ```bash
   allure generate results/allure-results -o results/allure-report --clean
   allure open results/allure-report
   ```

---

## 📊 O que está incluído no Relatório Allure:
- Detalhamento de cada suíte e cenário de teste
- Passos e keywords executadas com parâmetros e durações
- Tags (`smoke`, `login_sucesso`, `login_erro`)
- Logs e status de cada verificação
- Evidências (screenshots da tela cheia com barra de tarefas) anexadas diretamente ao teste

*** Settings ***
# Configurações globais do projeto.

Documentation    Arquivo de configuração global de setup e teardown
# Arquivo responsável pela preparação e finalização dos testes.

Library    SeleniumLibrary
# Importa a biblioteca SeleniumLibrary para automação web.

Library    String
# Importa a biblioteca String para manipulação de textos.

Library    ${CURDIR}/evidencias.py
# Importa a biblioteca personalizada para captura da tela cheia e opções limpas do Chrome.

*** Variables ***
# Variáveis globais da suíte.

${URL}        https://www.saucedemo.com/
# URL da aplicação a ser testada.

${BROWSER}    chrome
# Navegador utilizado na execução dos testes.

*** Keywords ***
# Keywords reutilizáveis.

Abrir Navegador
    # Abre o navegador aplicando opções para desabilitar o modal de troca de senha ("Mude sua senha"),
    # notificações e o gerenciador de credenciais do Google Chrome.

    ${options}=    Obter Opcoes Do Chrome
    Open Browser   url=${URL}    browser=${BROWSER}    options=${options}

    Maximize Browser Window
    # Maximiza a janela do navegador.

    Set Selenium Speed    0.5s
    # Adiciona 0,5 segundo de espera entre cada comando Selenium.
    # Isso desacelera a execução para facilitar o acompanhamento visual.

Fechar Navegador
    # Executado após cada caso de teste.

    Sleep    1s
    # Aguarda 1 segundo antes da captura.
    # Garante que a tela e a barra de tarefas do sistema operacional estejam totalmente renderizadas.

    ${nome_arquivo}=    Replace String    ${TEST NAME}    :     - 
    ${nome_arquivo}=    Replace String    ${nome_arquivo}    :    -

    Tirar Screenshot Desktop    evidencias/${nome_arquivo}.png
    # Captura a tela inteira do computador (incluindo a barra de tarefas com data e hora).
    # O arquivo será salvo na pasta de evidências e anexado ao log do Robot.

    Close Browser
    # Fecha o navegador e encerra a sessão do WebDriver.

    # Fecha o navegador e encerra a sessão do WebDriver.
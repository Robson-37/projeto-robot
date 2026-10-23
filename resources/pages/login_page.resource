*** Settings ***
# Seção de configurações do arquivo.

Documentation    Mapeamento e ações da tela de Login
# Descreve o propósito deste arquivo, que contém os elementos
# e ações relacionadas à tela de login.

Library    SeleniumLibrary
# Importa a biblioteca SeleniumLibrary para automação web.

*** Variables ***
# Seção destinada às variáveis globais.

# Mapeamento dos Locators
# Armazena os localizadores dos elementos da página.

${INPUT_USERNAME}    id=user-name
# Campo de usuário localizado pelo atributo id="user-name".

${INPUT_PASSWORD}    id=password
# Campo de senha localizado pelo atributo id="password".

${BTN_LOGIN}    id=login-button
# Botão de login localizado pelo atributo id="login-button".

${MSG_ERRO}    css=[data-test="error"]
# Mensagem de erro localizada através de um seletor CSS.

*** Keywords ***
# Seção que contém palavras-chave reutilizáveis.

Preencher Usuario
    # Keyword responsável por preencher o campo usuário.

    [Arguments]    ${username}
    # Recebe o nome do usuário como parâmetro.

    Input Text    ${INPUT_USERNAME}    ${username}
    # Digita o valor recebido no campo de usuário.

Preencher Senha
    # Keyword responsável por preencher o campo senha.

    [Arguments]    ${password}
    # Recebe a senha como parâmetro.

    Input Password    ${INPUT_PASSWORD}    ${password}
    # Digita a senha no campo correspondente.
    # O Robot Framework oculta o valor da senha nos logs.

Clicar No Botao Login
    # Keyword responsável por clicar no botão Login.

    Click Button    ${BTN_LOGIN}
    # Realiza o clique no botão de login.

    # Envia a tecla ESCAPE para fechar qualquer eventual modal ou balão nativo do navegador
    Sleep         0.5s
    Press Keys    None    ESCAPE

Realizar Login Completo
    # Keyword composta que executa o fluxo completo de login.

    [Arguments]    ${username}    ${password}
    # Recebe usuário e senha.

    Preencher Usuario    ${username}
    # Preenche o campo usuário.

    Preencher Senha    ${password}
    # Preenche o campo senha.

    Clicar No Botao Login
    # Clica no botão Login.

Validar Mensagem De Erro
    # Keyword responsável por validar mensagens de erro.

    [Arguments]    ${mensagem_esperada}
    # Recebe a mensagem de erro esperada.

    Element Should Contain    ${MSG_ERRO}    ${mensagem_esperada}
    # Verifica se o elemento de erro contém o texto esperado.
    # O teste falhará caso a mensagem não seja encontrada.

    # O teste falhará caso a mensagem não seja encontrada.
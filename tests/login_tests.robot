*** Settings ***
# Seção de configurações da suíte de testes.

Documentation    Suíte de testes para validação da funcionalidade de Login
# Descreve o objetivo desta suíte de testes.

Resource    ../resources/base.resource
# Importa o arquivo de recursos global contendo setup, teardown
# e configurações compartilhadas.

Resource    ../resources/pages/login_page.resource
# Importa as keywords e locators da página de Login.

Resource    ../resources/pages/inventory_page.resource
# Importa as keywords e locators da página de Inventário/Produtos.

Test Setup    Abrir Navegador
# Executa a keyword "Abrir Navegador" antes de cada caso de teste.

Test Teardown    Fechar Navegador
# Executa a keyword "Fechar Navegador" após cada caso de teste.
# Nesta etapa também será gerada a evidência (screenshot).

*** Test Cases ***
# Seção que contém os cenários de teste.

Cenário 01: Login com sucesso 
    # Valida que um usuário válido consegue acessar o sistema.

    [Tags]    smoke    login_sucesso
    # Tags para organização e execução seletiva dos testes.
    # smoke = teste crítico do sistema.
    # login_sucesso = categoria do cenário.

    Realizar Login Completo
    ...    username=standard_user
    ...    password=secret_sauce
    # Executa o login utilizando credenciais válidas.

    Validar Login Com Sucesso
    # Verifica se o usuário foi redirecionado para a tela de produtos.

Cenário 02: Login com usuário bloqueado
    # Valida o comportamento do sistema para um usuário bloqueado.

    [Tags]    login_erro
    # Tag para identificar cenários de erro de login.

    Realizar Login Completo
    ...    username=locked_out_user
    ...    password=secret_sauce
    # Tenta realizar login com usuário bloqueado.

    Validar Mensagem De Erro
    ...    mensagem_esperada=Epic sadface: Sorry, this user has been locked out.
    # Verifica se a mensagem de usuário bloqueado é exibida corretamente.

Cenário 03: Login com senha incorreta
    # Valida o comportamento do sistema quando a senha está incorreta.

    [Tags]    login_erro
    # Tag para identificar cenários de falha de autenticação.

    Realizar Login Completo
    ...    username=standard_user
    ...    password=senha_errada
    # Tenta realizar login com senha inválida.

    Validar Mensagem De Erro
    ...    mensagem_esperada=Epic sadface: Username and password do not match any user in this service
    # Verifica se a mensagem de credenciais inválidas é apresentada.
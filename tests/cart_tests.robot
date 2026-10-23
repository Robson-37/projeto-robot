*** Settings ***
# Seção de configurações da suíte de testes do carrinho.

Documentation    Suíte de testes para validação das funcionalidades do Carrinho de Compras
# Abrange a adição de produtos ao carrinho, validação de badges e conferência dos itens.

Resource    ../resources/base.resource
# Importa o arquivo global com setup, teardown e biblioteca de evidências.

Resource    ../resources/pages/login_page.resource
# Importa as keywords para autenticação no sistema.

Resource    ../resources/pages/inventory_page.resource
# Importa as keywords e locators da tela de produtos/inventário.

Resource    ../resources/pages/cart_page.resource
# Importa as keywords e locators da tela do carrinho de compras.

Test Setup       Abrir Navegador E Realizar Login
# Garante que o navegador seja aberto e o usuário autenticado antes de cada cenário.

Test Teardown    Fechar Navegador
# Garante a captura de tela (evidência com barra de tarefas) e fechamento do browser.

*** Keywords ***
Abrir Navegador E Realizar Login
    # Prepara o estado inicial para os testes de carrinho realizando login prévio.
    Abrir Navegador
    Realizar Login Completo    username=standard_user    password=secret_sauce
    Validar Login Com Sucesso

*** Test Cases ***
Cenário 04: Adicionar produto ao carrinho com sucesso
    # Valida que um usuário autenticado consegue adicionar um produto ao carrinho.
    [Tags]    smoke    carrinho    adicionar_produto

    Adicionar Produto Ao Carrinho    Sauce Labs Backpack
    # Adiciona a mochila Sauce Labs Backpack ao carrinho.

    Validar Quantidade De Itens No Carrinho    1
    # Valida se o contador do carrinho exibe o número "1".

    Acessar Carrinho De Compras
    # Navega até a página do carrinho de compras.

    Validar Pagina Do Carrinho
    # Confirma que está na página "Your Cart".

    Validar Produto Presente No Carrinho    Sauce Labs Backpack
    # Confirma que o produto adicionado está de fato presente na listagem.

Cenário 05: Adicionar múltiplos produtos ao carrinho
    # Valida a adição de múltiplos produtos e a soma correta no contador do carrinho.
    [Tags]    carrinho    multiplos_produtos

    Adicionar Produto Ao Carrinho    Sauce Labs Backpack
    Adicionar Produto Ao Carrinho    Sauce Labs Bike Light
    # Adiciona dois produtos distintos ao carrinho.

    Validar Quantidade De Itens No Carrinho    2
    # Valida se o contador do carrinho foi atualizado para "2".

    Acessar Carrinho De Compras
    Validar Pagina Do Carrinho
    Validar Produto Presente No Carrinho    Sauce Labs Backpack
    Validar Produto Presente No Carrinho    Sauce Labs Bike Light
    # Valida que ambos os produtos constam no carrinho.


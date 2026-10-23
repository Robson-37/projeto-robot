*** Settings ***
# Seção destinada às configurações do arquivo.

Documentation    Mapeamento e ações da tela de Inventário / Produtos
# Descreve a finalidade deste arquivo, que contém os elementos
# e ações relacionados à página de produtos após o login.

Library    SeleniumLibrary
# Importa a biblioteca SeleniumLibrary para automação web.

*** Variables ***
# Seção de variáveis globais utilizadas neste arquivo.

${TITLE_PRODUCTS}         css=.title
# Localizador do título da página de produtos ("Products").

${SHOPPING_CART}          css=.shopping_cart_link
# Localizador do ícone/link do carrinho de compras.

${CART_BADGE}             css=.shopping_cart_badge
# Indicador numérico (badge) de quantidade de itens no carrinho.

${BTN_ADD_BACKPACK}       id=add-to-cart-sauce-labs-backpack
# Botão para adicionar a mochila Sauce Labs Backpack.

${BTN_ADD_BIKE_LIGHT}     id=add-to-cart-sauce-labs-bike-light
# Botão para adicionar a lanterna Sauce Labs Bike Light.

*** Keywords ***
# Seção que contém as palavras-chave reutilizáveis.

Validar Login Com Sucesso
    # Valida se o usuário foi direcionado corretamente para a página de produtos.

    Wait Until Element Is Visible    ${TITLE_PRODUCTS}    timeout=5s
    Element Text Should Be           ${TITLE_PRODUCTS}    Products

Adicionar Produto Ao Carrinho
    # Keyword que adiciona um produto ao carrinho convertendo o nome para o id padrão do SauceDemo.
    # Exemplo: "Sauce Labs Backpack" -> id="add-to-cart-sauce-labs-backpack"
    [Arguments]    ${nome_produto}

    ${id_formatado}=    Evaluate    'add-to-cart-' + '${nome_produto}'.lower().replace(' ', '-')
    Wait Until Element Is Visible    id=${id_formatado}    timeout=5s
    Click Button                     id=${id_formatado}

Adicionar Mochila Ao Carrinho
    # Keyword de conveniência para adicionar diretamente a mochila.
    Wait Until Element Is Visible    ${BTN_ADD_BACKPACK}    timeout=5s
    Click Button                     ${BTN_ADD_BACKPACK}

Validar Quantidade De Itens No Carrinho
    # Valida o contador no badge do carrinho com espera explícita.
    [Arguments]    ${quantidade_esperada}

    Wait Until Element Is Visible    ${CART_BADGE}    timeout=5s
    Element Text Should Be           ${CART_BADGE}    ${quantidade_esperada}

Acessar Carrinho De Compras
    # Clica no ícone do carrinho e navega até ele.

    Wait Until Element Is Visible    ${SHOPPING_CART}    timeout=5s
    Click Element                    ${SHOPPING_CART}

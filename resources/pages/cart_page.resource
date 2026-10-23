*** Settings ***
# Seção de configurações da página do Carrinho de Compras.

Documentation    Mapeamento e ações da tela do Carrinho de Compras (cart.html)
# Contém os elementos e ações relacionados à página de visualização dos itens adicionados.

Library    SeleniumLibrary
# Importa a biblioteca SeleniumLibrary para automação web.

*** Variables ***
# Variáveis e locators da página do carrinho.

${TITLE_CART}          css=.title
# Título da página do carrinho ("Your Cart").

${CART_LIST}           css=.cart_list
# Container contendo os itens presentes no carrinho.

${BTN_CHECKOUT}        id=checkout
# Botão de prosseguir para o checkout.

${BTN_CONTINUE_SHOP}   id=continue-shopping
# Botão para continuar comprando.

*** Keywords ***
# Keywords da página do carrinho.

Validar Pagina Do Carrinho
    # Valida se a página atual é a tela do carrinho de compras.

    Wait Until Element Is Visible    ${TITLE_CART}    timeout=5s
    Element Text Should Be           ${TITLE_CART}    Your Cart

Validar Produto Presente No Carrinho
    # Valida se um determinado produto está listado no carrinho.
    [Arguments]    ${nome_produto}

    Wait Until Element Is Visible    ${CART_LIST}    timeout=5s
    Element Should Contain           ${CART_LIST}    ${nome_produto}

Remover Produto Do Carrinho
    # Remove um produto da lista do carrinho pelo nome.
    [Arguments]    ${nome_produto}

    ${id_remove}=    Evaluate    'remove-' + '${nome_produto}'.lower().replace(' ', '-')
    Wait Until Element Is Visible    id=${id_remove}    timeout=5s
    Click Button                     id=${id_remove}

*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Resource        ../resources/base.resource

# Suite Setup         Log    Tudo aqui ocorre antes da Suite (antes de todos os testes)
# Suite Teardown      Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)

Test Setup          Start Session
Test Teardown       Take Screenshot

# TESTES INDEPENDENTES
*** Test Cases ***
Deve poder cadastrar um novo usuário
    
    ${user}        Create Dictionary        
    ...        name= Denis SL    
    ...        email=denis.dvps@gmail.com    
    ...        password=pwd123

    Remove user from database        ${user}[email]             

    Go To              ${BASE_URL}/signup
    
    #Checkpoint
    Wait For Elements State        css=h1        visible        5
    Get Text                       css=h1        equal          Faça seu cadastro
    
    # Caso não exista o elemento ID outras formas de melhorar a estratégia pensando na continuidade do Projeto a longo prazo
    Fill Text          css=input[name=name]          ${user}[name]
    Fill Text          css=input[name=email]         ${user}[email]
    Fill Text          css=input[name=password]      ${user}[password]

    Click              css=button[type=submit] >> text=Cadastrar
                    #  xpath=//button[text()="Cadastrar"]

    Wait For Elements State        css=.notice p        visible        5
    Get Text                       css=.notice p        equal          Boas vindas ao Mark85, o seu gerenciador de tarefas.
    

Não deve permitir o cadastro com email duplicado
    [Tags]        dup
    
    ${user}        Create Dictionary    
    ...        name=Lima dos Santos Denis
    ...        email=dvps.denis@gmail.com
    ...        password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go To              ${BASE_URL}/signup
    
    #Checkpoint
    Wait For Elements State        css=h1        visible        5
    Get Text                       css=h1        equal          Faça seu cadastro
    
    # Caso não exista o elemento ID outras formas de melhorar a estratégia pensando na continuidade do Projeto a longo prazo
    Fill Text          css=input[name=name]          ${user}[name]
    Fill Text          css=input[name=email]         ${user}[email]
    Fill Text          css=input[name=password]      ${user}[password]

    Click              css=button[type=submit] >> text=Cadastrar
                    #  xpath=//button[text()="Cadastrar"]
                    
    Wait For Elements State        css=.notice p        visible        5
    Get Text                       css=.notice p        equal          Oops! Já existe uma conta com o e-mail informado.
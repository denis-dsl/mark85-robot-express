*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Resource        ../resources/base.resource

*** Variables ***
${name}        Denis dos Santos Lima
${email}       denis.dvps@gmail.com
${password}    pwd123


# TESTES DEPENDENTES
*** Test Cases ***
Deve poder cadastrar um novo usuário

    # ${name}            Set Variable        Denis dos Santos Lima
    # ${email}           Set Variable        denis.dvps@gmail.com
    # ${password}        Set Variable        pwd123

    Remove user from database        ${email}             
       
    Start Session

    Go To              ${BASE_URL}/signup
    
    #Checkpoint
    Wait For Elements State        css=h1        visible        5
    Get Text                       css=h1        equal          Faça seu cadastro
    
    #Fill Text         id=name                            ${name}
    #  o # busca por id
    Fill Text          css=#name                          ${name}            # só há uma ocorrência na página para 'name'
    Fill Text          id=email                          ${email}
    Fill Text          xpath=//input[@id="password"]      ${password}        # só há uma ocorrência na página para 'password'
    #Fill Text         id=password                        pwd123

    Click              id=buttonSignup
    
    # o . busca por classe
    Wait For Elements State        css=.notice p        visible        5
    Get Text                       css=.notice p        equal          Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir o cadastro com email duplicado
    [Tags]        dup

    Start Session
    Go To              ${BASE_URL}/signup
    
    #Checkpoint
    Wait For Elements State        css=h1        visible        5
    Get Text                       css=h1        equal          Faça seu cadastro

    Fill Text          id=name        ${name}           
    Fill Text          id=email       ${email}
    Fill Text          id=password    ${password}        

    Click              id=buttonSignup

    Wait For Elements State        css=.notice p        visible        5
    Get Text                       css=.notice p        equal          Oops! Já existe uma conta com o e-mail informado.
    
    Sleep    5
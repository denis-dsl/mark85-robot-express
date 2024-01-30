*** Settings ***
Documentation        Ações e elementos da página de cadastro de tarefas

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]        ${task}
    
    Fill Text        css=input[placeholder$=tarefa]        ${task}[name]

    ${tags_element}        Set Variable        css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text         ${tags_element}        ${tag}
        Sleep        1     # Simula o tempo que o usuário está pensando thinking time
        Press Keys        ${tags_element}        Enter
    END

    Click            css=button >> text=Cadastrar




# <input name="name" type="text" placeholder="Nome da tarefa" value="">

# input[placeholder$="tarefa"] = termina com tarefa
# input[placeholder^="Nome"] = começa com Nome
# input[placeholder*="da"] = contains ou contém da

# Aspas duplas é utilizado quando há caracter especial, quando não tiver nenhum não é necessário usar as aspas.
# Ex.: 
# input[placeholder$=tarefa]
*** Settings ***
Documentation    Testes CRUD de usuários
Resource           ../../../resources/common/api_session.resource
Resource           ../../../resources/common/assertions.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions
Test Tags       api    users


*** Test Cases ***
Get User By ID Should Return Valid User
    [Documentation]    Busca usuário por ID e valida campos obrigatórios
    [Tags]             regression
    ${response}=       GET On Session    api    /users/1    expected_status=200
    ${user}=           Get JSON Response    ${response}
    Dictionary Should Contain Keys    ${user}    id    name    username    email
    Should Be Equal As Integers    ${user}[id]    1

Get All Users Should Return List
    [Documentation]    Lista todos os usuários
    [Tags]             smoke
    ${response}=       GET On Session    api    /users    expected_status=200
    ${users}=          Get JSON Response    ${response}
    Length Should Be   ${users}    10

Create User Should Return 201
    [Documentation]    Cria novo usuário via POST
    [Tags]             regression
    VAR    &{payload}    name=Jane Doe    username=janedoe    email=jane@example.com
    ${response}=       POST On Session    api    /users    json=${payload}    expected_status=201
    ${user}=           Get JSON Response    ${response}
    Should Be Equal    ${user}[name]    Jane Doe
    Should Be Equal    ${user}[email]    jane@example.com

Update User Should Return 200
    [Documentation]    Atualiza usuário existente via PUT
    [Tags]             regression
    VAR    &{payload}    id=1    name=Updated Name    username=bret    email=updated@example.com
    ${response}=       PUT On Session    api    /users/1    json=${payload}    expected_status=200
    ${user}=           Get JSON Response    ${response}
    Should Be Equal    ${user}[name]    Updated Name

Delete User Should Return 200
    [Documentation]    Remove usuário via DELETE
    [Tags]             regression
    DELETE On Session    api    /users/1    expected_status=200

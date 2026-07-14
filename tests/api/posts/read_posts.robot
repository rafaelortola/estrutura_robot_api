*** Settings ***
Documentation    Testes de leitura de posts
Resource           ../../../resources/common/api_session.resource
Resource           ../../../resources/common/assertions.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions
Test Tags       api    posts


*** Test Cases ***
Get All Posts Should Return 100 Items
    [Documentation]    Lista todos os posts e valida quantidade
    [Tags]             smoke
    ${response}=       GET On Session    api    /posts    expected_status=200
    ${posts}=          Get JSON Response    ${response}
    Length Should Be   ${posts}    100

Get Post By ID Should Have Required Fields
    [Documentation]    Busca post por ID e valida campos obrigatórios
    [Tags]             regression
    ${response}=       GET On Session    api    /posts/1    expected_status=200
    ${post}=           Get JSON Response    ${response}
    Dictionary Should Contain Keys    ${post}    id    userId    title    body
    Should Be Equal As Integers    ${post}[id]    1

Get Posts By User Should Return List
    [Documentation]    Filtra posts por userId
    [Tags]             smoke
    VAR    &{params}    userId=1
    ${response}=       GET On Session    api    /posts    params=${params}    expected_status=200
    ${posts}=          Get JSON Response    ${response}
    Length Should Be   ${posts}    10

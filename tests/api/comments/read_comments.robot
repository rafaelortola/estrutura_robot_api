*** Settings ***
Documentation    Testes de leitura de comentários
Resource           ../../../resources/common/api_session.resource
Resource           ../../../resources/common/assertions.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions
Test Tags       api    comments


*** Test Cases ***
Get All Comments Should Return List
    [Documentation]    Lista todos os comentários
    [Tags]             smoke
    ${response}=       GET On Session    api    /comments    expected_status=200
    ${comments}=       Get JSON Response    ${response}
    Length Should Be   ${comments}    500

Get Comment By ID Should Have Required Fields
    [Documentation]    Busca comentário por ID e valida estrutura
    [Tags]             regression
    ${response}=       GET On Session    api    /comments/1    expected_status=200
    ${comment}=        Get JSON Response    ${response}
    Dictionary Should Contain Keys    ${comment}    id    postId    name    email    body

Get Comments For Post Should Return List
    [Documentation]    Filtra comentários por postId
    [Tags]             smoke
    VAR    &{params}    postId=1
    ${response}=       GET On Session    api    /comments    params=${params}    expected_status=200
    ${comments}=       Get JSON Response    ${response}
    Length Should Be   ${comments}    5

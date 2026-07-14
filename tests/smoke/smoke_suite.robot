*** Settings ***
Documentation    Suite de smoke tests consolidada
Resource           ../../resources/common/api_session.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions

*** Test Cases ***
Smoke - API Is Reachable
    [Documentation]    Verifica conectividade básica com a API
    [Tags]             smoke
    ${response}=       GET On Session    api    /posts/1    expected_status=200
    Should Be Equal As Integers    ${response.status_code}    200

Smoke - API Returns Valid JSON
    [Documentation]    Verifica que a API retorna JSON válido
    [Tags]             smoke
    ${response}=       GET On Session    api    /users/1    expected_status=200
    ${json}=           Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    id
    Dictionary Should Contain Key    ${json}    name

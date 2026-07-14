*** Settings ***
Documentation    Testes de autenticação e autorização
Resource           ../../../resources/common/api_session.resource
Resource           ../../../resources/common/auth.resource
Resource           ../../../resources/common/assertions.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions
Test Tags       api    auth


*** Test Cases ***
Access Protected Resource Without Token
    [Documentation]    API pública deve permitir acesso sem token
    [Tags]             smoke
    ${response}=       GET On Session    api    /users/1    expected_status=200
    Response Should Have Status    ${response}    200

Access With Invalid Endpoint Should Return 404
    [Documentation]    Endpoint inexistente deve retornar 404
    [Tags]             regression
    ${response}=       GET On Session    api    /invalid-endpoint    expected_status=404
    Response Should Have Status    ${response}    404

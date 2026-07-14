*** Settings ***
Documentation    Smoke tests - Health check da API
Resource           ../../../resources/common/api_session.resource
Resource           ../../../resources/common/assertions.resource
Suite Setup        Create API Session
Suite Teardown     Delete All Sessions
Test Tags       api    health    smoke


*** Test Cases ***
Health Check - GET Posts Should Return 200
    [Documentation]    Verifica se a API responde com status 200
    ${response}=       GET On Session    api    /posts    expected_status=200
    Response Should Have Status    ${response}    200
    ${json}=           Get JSON Response    ${response}
    Length Should Be   ${json}    100

Health Check - Response Time Under 5 Seconds
    [Documentation]    Valida tempo de resposta da API
    [Tags]             performance
    ${response}=       GET On Session    api    /posts/1    expected_status=200
    Response Time Should Be Less Than    ${response}    5000

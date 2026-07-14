*** Settings ***
Documentation    Keywords para criação de sessão HTTP e manipulação de respostas JSON
Library    Collections
Library    RequestsLibrary


*** Keywords ***
Create API Session
    [Documentation]    Cria sessão HTTP reutilizável para testes de API
    [Arguments]    ${alias}=api    ${base_url}=${BASE_URL}
    Create Session    ${alias}    ${base_url}    verify=${True}
    ...    headers={"Content-Type": "application/json", "Accept": "application/json"}

Get JSON Response
    [Documentation]    Retorna o corpo da resposta como dicionário Python
    [Arguments]    ${response}
    VAR    ${json}    ${response.json()}
    RETURN    ${json}

Response Should Have Status
    [Documentation]    Valida status code da resposta HTTP
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}

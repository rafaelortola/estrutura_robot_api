*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create Authenticated Session
    [Documentation]    Cria sessão com token de autenticação (Bearer)
    [Arguments]    ${alias}=api    ${base_url}=${BASE_URL}    ${token}=${API_TOKEN}
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Authorization=Bearer ${token}
    Create Session    ${alias}    ${base_url}    verify=${True}    headers=${headers}

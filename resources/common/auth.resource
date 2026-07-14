*** Settings ***
Documentation    Keywords para autenticação via Bearer token
Library    RequestsLibrary


*** Keywords ***
Create Authenticated Session
    [Documentation]    Cria sessão com token de autenticação (Bearer)
    [Arguments]    ${alias}=api    ${base_url}=${BASE_URL}    ${token}=${API_TOKEN}
    VAR    &{headers}    Content-Type=application/json    Accept=application/json    Authorization=Bearer ${token}
    Create Session    ${alias}    ${base_url}    verify=${True}    headers=${headers}

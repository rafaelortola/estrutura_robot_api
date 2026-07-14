*** Settings ***
Documentation    Keywords de asserção para validação de respostas HTTP e JSON
Library    Collections
Library    JSONLibrary


*** Keywords ***
Dictionary Should Contain Keys
    [Documentation]    Valida que o dicionário contém todas as chaves esperadas
    [Arguments]    ${dictionary}    @{expected_keys}
    FOR    ${key}    IN    @{expected_keys}
        Dictionary Should Contain Key    ${dictionary}    ${key}
    END

Response JSON Should Contain Key
    [Documentation]    Valida que a resposta JSON contém uma chave específica
    [Arguments]    ${response}    ${key}
    VAR    ${json}    ${response.json()}
    Dictionary Should Contain Key    ${json}    ${key}

Response Time Should Be Less Than
    [Documentation]    Valida tempo de resposta em milissegundos
    [Arguments]    ${response}    ${max_ms}
    VAR    ${elapsed}    ${response.elapsed.total_seconds() * 1000}
    Should Be True    ${elapsed} < ${max_ms}
    ...    msg=Response time ${elapsed}ms exceeded ${max_ms}ms

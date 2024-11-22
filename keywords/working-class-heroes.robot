*** Settings ***
Documentation       Keyword file for working class heroes
Library             SeleniumLibrary
Library             Collections
Library             RequestsLibrary
Resource            ../object-repo/apiObject.robot
Resource            ../keywords/generic.robot
Resource            ../keywords/sql-helper.robot

*** Keywords ***
Create Hero API
    [Documentation]    Calling Post Request To Create Hero
    [Arguments]    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${expected_status}
    ${dict}=    Create Dictionary    natid=${natid}    name=${name}    gender=${gender}    birthDate=${birthDate}    deathDate=${deathDate}    salary=${salary}    taxPaid=${taxPaid}    browniePoints=${browniePoints}
    ${dict_payload}=    Replace Null In Dictionary    ${dict}
    Log And Log To Console    \n\nCalling API To Create Hero ${create_hero_api}\n
    Log And Log To Console    Dictionary For Request Payload:\n${dict_payload}\n
    ${response}=    POST    ${create_hero_api}    json=${dict_payload}    expected_status=any
    Log And Log To Console    API Response Response:\n\tExpected Status Code:${expected_status}\n\tActual Status Code: ${response.status_code}\n\tResponse Body: ${response.text}\n\n
    Should Be Equal As Strings    ${expected_status}    ${response.status_code}
    [Return]    ${response}

Create Hero With Voucher API
    [Documentation]    Calling Post Request To Create Hero With Voucher
    [Arguments]    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${vouchers:voucherName}    ${vouchers:voucherType}    ${expected_status}
    ${voucher_dict}=    Create Dictionary    voucherName=${vouchers:voucherName}    voucherType=${vouchers:voucherType}
    ${voucher_dict}=    Replace Null In Dictionary    ${voucher_dict}
    ${voucher_dict_list}=    Create List    ${voucher_dict}
    ${dict}=    Create Dictionary    natid=${natid}    name=${name}    gender=${gender}    birthDate=${birthDate}    deathDate=${deathDate}    salary=${salary}    taxPaid=${taxPaid}    browniePoints=${browniePoints}
    ${dict_payload}=    Replace Null In Dictionary    ${dict}
    Set To Dictionary    ${dict_payload}    vouchers=${voucher_dict_list}
    Log And Log To Console    \n\nCalling API To Create Hero With Voucher ${create_hero_voucher_api}\n
    Log And Log To Console    Dictionary For Request Payload:\n${dict_payload}\n
    ${response}=    POST    ${create_hero_voucher_api}    json=${dict_payload}    expected_status=any
    Log And Log To Console    API Response Response:\n\tExpected Status Code:${expected_status}\n\tActual Status Code: ${response.status_code}\n\tResponse Body: ${response.text}\n\n
    Should Be Equal As Strings    ${expected_status}    ${response.status_code}
    [Return]    ${response}

Verify Create Hero API Response Message
    [Documentation]    Verify The Status Code And Message Of The Created Hero Via API
    [Arguments]    ${response}    ${flow}    ${expectedErrMessage}
    IF    '${flow}' == 'Positive'
        ${response_json}=    Set Variable    ${response.json()}
        Should Be Equal As Strings    ${response_json['message']}    ${None}
    ELSE
        IF    '${expectedErrMessage}' != '${EMPTY}'
            ${response_json}=    Set Variable    ${response.json()}
            Should Be Equal As Strings    ${response_json['errorMsg']}    ${expectedErrMessage}
        ELSE
            Should Be Equal As Strings    ${response.text}    ${expectedErrMessage}
        END
    END

Verify Create Hero With Voucher API Response Message
    [Documentation]    Verify The Status Code And Message Of The Created Hero Via API
    [Arguments]    ${response}    ${flow}    ${expectedErrMessage}
    IF    '${flow}' == 'Positive'
        Should Be Equal As Strings    ${response.text}    ${EMPTY}
    ELSE
        IF    '${expectedErrMessage}' != '${EMPTY}'
            ${response_json}=    Set Variable    ${response.json()}
            Should Be Equal As Strings    ${response_json['errorMsg']}    ${expectedErrMessage}
        ELSE
            Should Be Equal As Strings    ${response.text}    ${expectedErrMessage}
        END
    END

Verify Created Hero Against DB
    [Documentation]    Verify API Created Hero Exist In DB
    [Arguments]    ${natid}    ${actual_response}
    ${sql_dict}=    Create Dictionary    value_natid=${natid}
    ${sql_response}=    Query Database    select_hero_by_natid    ${sql_dict}
    Log And Log To Console    \nSQL Query Response:\n${sql_response}

Verify Voucher Created Against DB
    [Documentation]    Verify API Voucher Exist In DB
    [Arguments]    ${natid}    ${vouchers:voucherName}    ${vouchers:voucherType}
    ${sql_dict}=    Create Dictionary    value_natid=${natid}
    ${voucher_sql_response}=    Query Database    select_voucher_by_hero_id    ${sql_dict}
    Log And Log To Console    \nSQL Query Response:\n${voucher_sql_response}

Setup Working Class Heroes Clear DB Data
    [Documentation]    Precondition to clear DB data before running test
    [Arguments]    ${natid}
    ${cleanup_dict}=    Create Dictionary    value_natid=${natid}
    Query Database    delete_hero_by_natid    ${cleanup_dict}

Setup Working Class Heroes With Voucher Clear DB Data
    [Documentation]    Precondition to clear DB data before running test
    [Arguments]    ${natid}
    ${cleanup_dict}=    Create Dictionary    value_natid=${natid}
    Query Database    delete_voucher    ${cleanup_dict}
    Setup Working Class Heroes Clear DB Data    ${natid}

Get Hero Owe Money API
    [Documentation]    Calling Get Request To Get Whether Hero Owes Money
    [Arguments]    ${natid}    ${expected_status}
    ${natid_no}=    Remove String    ${natid}    natid-
    ${query_params}=    Set Variable    natid=${natid_no}
    Log And Log To Console    \n\nCalling API To Get Whether Hero Owes Money ${create_hero_api}\n
    Log And Log To Console    Query Params:\n${query_params}\n
    ${response}=    GET    ${get_hero_owe_money_api}?${query_params}    expected_status=any
    Log And Log To Console    API Response Response:\n\tExpected Status Code:${expected_status}\n\tActual Status Code: ${response.status_code}\n\tResponse Body: ${response.text}\n\n
    Should Be Equal As Strings    ${expected_status}    ${response.status_code}
    [Return]    ${response}

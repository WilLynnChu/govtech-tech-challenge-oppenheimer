*** Settings ***
Documentation       Keyword file for login
Library             OperatingSystem
Library             CSVLibrary
Resource            ../keywords/generic.robot
Resource            ../object-repo/loginObject.robot

*** Keywords ***
Get Login Credential
    [Documentation]    Get Book Keeper Login Credential From Credential Data Files
    [Arguments]    ${role}
    ${credential_dict_list}=    Read Csv File To Associative    ./test-data/role-credential.csv
    FOR    ${item}    IN    @{credential_dict_list}
        IF    '${item['role']}' == '${role}'
            ${username}=    Set Variable    ${item['username']}
            ${password}=    Set Variable    ${item['password']}
        END
    END
    [Return]    ${username}    ${password}


Login With Credential
    [Documentation]    Login With Credential
    [Arguments]    ${role}
    Page Should Contain Element With Scroll And Retry    ${lbl_header_login}
    ${username}    ${password}=    Get Login Credential    ${role}
    Input Text With Scroll And Retry    ${input_username_login}    ${username}
    Input Text With Scroll And Retry    ${input_password_login}    ${password}
    Click Element With Scroll And Retry    ${btn_submit_login}
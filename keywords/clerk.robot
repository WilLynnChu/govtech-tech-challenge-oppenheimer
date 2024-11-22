*** Settings ***
Documentation       Keyword file for clerk dashboard
Library             OperatingSystem
Library             CSVLibrary
Resource            ../keywords/generic.robot
Resource            ../keywords/login.robot
Resource            ../keywords/sql-helper.robot
Resource            ../object-repo/loginObject.robot
Resource            ../object-repo/clerkObject.robot

*** Keywords ***
Setup Clerk Clear DB Data
    [Documentation]    Precondition to clear DB data before running test
    [Arguments]    ${test_data_path}
#   Get data to be deleted from CSV file
    ${csv_list}=    Read Csv File To List    ${test_data_path}
#   Loop and delete data from DB using natid
    FOR    ${item}    IN    @{csv_list}
        ${cleanup_dict}=    Create Dictionary    value_natid=${item[0]}
        Query Database    delete_hero_by_natid    ${cleanup_dict}
    END

Login As Clerk
    [Documentation]    Login As Clerk
    Log And Log To Console    Logging In As Clerk
    Login With Credential    Clerk

Upload CSV Files Via Clerk Dashboard
    [Documentation]    Upload CSV files from clerk dashboard to create heroes
    [Arguments]    ${test_data_path}    ${flow}
    Log And Log To Console    Upload CSV files from clerk dashboard to create heroes
    Page Should Contain Element With Scroll And Retry    ${lbl_header_clerk}
    Click Element With Scroll And Retry    ${btn_add_hero_clerk}
    Click Element With Scroll And Retry    ${dropdown_option_upload_csv_clerk}
    Page Should Contain Element With Scroll And Retry    ${input_upload_csv_file_clerk}
    Log And Log To Console    Uploading CSV Files From Path "${test_data_path}"
    Choose File    ${input_upload_csv_file_clerk}    ${test_data_path}
    Click Element With Scroll And Retry    ${btn_create_clerk}
#    Expecting different label based On Positive Or Negative Flow
    IF    '${flow}' == 'Positive'
        Page Should Contain Element With Scroll And Retry    ${lbl_created_success_clerk}
    ELSE
        Page Should Contain Element With Scroll And Retry    ${lbl_created_unsuccess_warning_clerk}
    END
    Log And Log To Console    Uploaded Successfully

Verify Uploaded Data In DB
    [Documentation]    Verify uploaded heroes in DB
    [Arguments]    ${test_data_path}
#   Get data to be compared with DB
    ${csv_list}=    Read Csv File To List    ${test_data_path}
#   Loop and verify data uploaded in DB
    FOR    ${item}    IN    @{csv_list}
        ${dict}=    Create Dictionary    value_natid=${item[0]}
        ${sql_response}=    Query Database    select_hero_by_natid    ${dict}
        ${sql_response}=    Set Variable    ${sql_response}[0]
        Compare String    ${item[0]}    ${sql_response['natid']}    natid
        Compare String    ${item[1]}    ${sql_response['name']}    name
        Compare String    ${item[2]}    ${sql_response['gender']}    gender
        Compare Date    ${item[3]}    ${sql_response['birth_date']}    birth_date
        Compare Date    ${item[4]}    ${sql_response['death_date']}    death_date
        Compare Decimals    ${item[5]}    ${sql_response['salary']}    salary
        Compare Decimals    ${item[6]}    ${sql_response['tax_paid']}    tax_paid
        Compare Decimals    ${item[7]}    ${sql_response['brownie_points']}    brownie_points
    END

Verify Partial Uploaded Data In DB
    [Documentation]    Verify partial uploaded heroes in DB
    [Arguments]    ${test_data_path}    ${flow}    ${natid}=${EMPTY}
#   Get data to be compared with DB
    ${csv_list}=    Read Csv File To List    ${test_data_path}
#   If flow is positive, record is expected to exist in DB
    IF    '${flow}' == 'Positive'
        FOR    ${item}    IN    @{csv_list}
            IF    '${item[0]}' == '${natid}'
                ${dict}=    Create Dictionary    value_natid=${item[0]}
                ${sql_response}=    Query Database    select_hero_by_natid    ${dict}
                Run Keyword If    ${sql_response} == []    Fail    ${natid} not created in DB
                ${sql_response}=    Set Variable    ${sql_response}[0]
                Compare String    ${item[0]}    ${sql_response['natid']}    natid
                Compare String    ${item[1]}    ${sql_response['name']}    name
                Compare String    ${item[2]}    ${sql_response['gender']}    gender
                Compare Date    ${item[3]}    ${sql_response['birth_date']}    birth_date
                Compare Date    ${item[4]}    ${sql_response['death_date']}    death_date
                Compare Decimals    ${item[5]}    ${sql_response['salary']}    salary
                Compare Decimals    ${item[6]}    ${sql_response['tax_paid']}    tax_paid
                Compare Decimals    ${item[7]}    ${sql_response['brownie_points']}    brownie_points
            END
        END
#   If flow is negative, record is expected to not exist in DB
    ELSE
        FOR    ${item}    IN    @{csv_list}
            IF    '${item[0]}' == '${natid}'
                ${negative_col_name}=    Set Variable    ${item[2]}
            END
        END
            ${dict}=    Create Dictionary    value_natid=${natid}
            ${sql_response}=    Query Database    select_hero_by_natid    ${dict}
            Log And Log To Console    ${sql_response}
            IF    ${sql_response} != []
                ${sql_response}=    Set Variable    ${sql_response}[0]
                Log And Log To Console    ${sql_response}
                ${failure_msg}=    Set Variable    ${sql_response['${negative_col_name}']}
                Log And Log To Console    ${sql_response}
                Fail    Record created with invalid column named "${negative_col_name}": ${sql_response['${negative_col_name}']}
            END
    END
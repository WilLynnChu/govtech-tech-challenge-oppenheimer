*** Settings ***
Documentation       Keyword file for book keeper dashboard
Library             OperatingSystem
Library             CSVLibrary
Library             Collections
Resource            ../keywords/generic.robot
Resource            ../keywords/login.robot
Resource            ../keywords/sql-helper.robot
Resource            ../object-repo/loginObject.robot
Resource            ../object-repo/bkObject.robot

*** Keywords ***
Setup Book Keeper Clear DB Data
    [Documentation]    Precondition to clear DB data before running test
#   Delete relief file where status is not COMPLETED
    Query Database    delete_file_by_status

Login As Book Keeper
    [Documentation]    Login As Book Keeper
    Log And Log To Console    Logging In As Book Keeper
    Login With Credential    Book Keeper

Generate Tax Relief File
    [Documentation]    Generate and download tax relief file from book keeper dashboard
    Log And Log To Console    Generate and download tax relief file from book keeper dashboard
    Page Should Contain Element With Scroll And Retry    ${lbl_header_bk}
    Click Element With Scroll And Retry    ${btn_generate_tax_relief_clerk}
    Wait Until Keyword Succeeds    100x    50ms    Check Tax Relief File Exist

Check Tax Relief File Exist
    File Should Exist    ${DOWNLOAD_DIR}/tax_relief_file.txt

Verify Tax Relief File
#   Load Tax Relief File Content
    ${tax_relief_file_content}=    Read Csv File To List    ${DOWNLOAD_DIR}/tax_relief_file.txt
    ${list_size}=    Get Length    ${tax_relief_file_content}
    ${list_size}=    Evaluate    ${list_size} - 1

#   Get the footer (count) in the file content
    ${file_content_footer}=    Get From List    ${tax_relief_file_content}    ${list_size}
    ${file_content_footer}=    Set Variable    ${file_content_footer[0]}
    Remove From List    ${tax_relief_file_content}    ${list_size}

#   Get DB response to compare with actual file
    ${db_content}=    Query Database    select_hero
    Log And Log To Console    ${db_content}
    ${db_count}=    Query Database    select_count_hero

#   Comparing count and natid between bd result and actual file
    Compare String    ${db_count[0]['count']}    ${file_content_footer}    count
    FOR    ${row}    IN    @{tax_relief_file_content}
        ${db_loop_count}=    Set Variable    0
        FOR    ${dict}    IN    @{db_content}
            IF    '${dict['natid']}' == '${row[0]}'
                Remove From List    ${db_content}    ${db_loop_count}
            ELSE
                ${db_loop_count}=    Evaluate    ${db_loop_count} + 1
            END
        END
    END

Verify DB File Table
    ${test_current_date_time}=    Get Current Date    UTC    8 hours    result_format=%Y-%m-%d %H:%M:%S.%f
    ${test_start_date_time}=    Convert To String    ${test_start_date_time}
    ${test_current_date_time}=    Convert To String    ${test_current_date_time}
    ${sql_dict}=    Create Dictionary    value_start_time=${test_start_date_time}    value_current_time=${test_current_date_time}
    ${sql_file_response}=    Query Database    select_file_by_time_range    ${sql_dict}
    ${sql_file_response}=    Set Variable    ${sql_file_response[0]}
    Compare String    TAX_RELIEF    ${sql_file_response['file_type']}
    Compare String    COMPLETED    ${sql_file_response['file_status']}
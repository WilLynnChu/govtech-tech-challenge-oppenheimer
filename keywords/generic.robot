*** Settings ***
Documentation   Generic keyword file
Library         SeleniumLibrary
Library         OperatingSystem
Library         Collections
Library         DateTime
Resource        ../object-repo/apiObject.robot

*** Variables ***
${PROJ_DIR}     .
${REPORT_DIR}    ${PROJ_DIR}/reports
${SCREENSHOT_DIR}    ${REPORT_DIR}/screenshots
${DOWNLOAD_DIR}    ${EXEC_DIR}/reports/downloads
${execution_profile_chrome_name}    Chrome
${execution_profile_chrome_path}    executable_path=${PROJ_DIR}/drivers/chromedriver/chromedriver
${login_page}    ${base_url}/login

*** Keywords ***
Suite Setup Clean Reports
    Create Directory    ${REPORT_DIR}
    Create Directory    ${SCREENSHOT_DIR}
    Create Directory    ${DOWNLOAD_DIR}
    Empty Directory    ${SCREENSHOT_DIR}
    Empty Directory    ${DOWNLOAD_DIR}
    Set Screenshot Directory    ${SCREENSHOT_DIR}

Common Test Teardown
    Capture Page Screenshot    ${OUTPUT_DIR}/screenshots/${TEST NAME}.png
    Close Browser

Replace Null In Dictionary
    [Arguments]    ${json_dict}
    FOR    ${key}    ${value}    IN    &{json_dict}
        IF    '${value}' == 'null'
            Set To Dictionary    ${json_dict}    ${key}    ${None}
        END
    END
    [Return]    ${json_dict}

Compare String
    [Documentation]    Compare Strings
    [Arguments]    ${expected_string}    ${actual_string}    ${compare_title}=${EMPTY}
    Log And Log To Console    Expected ${compare_title}:\n${expected_string}\nActual ${compare_title}:\n${actual_string}
    Should Be Equal As Strings    ${expected_string}    ${actual_string}

Compare Decimals
    [Documentation]    Normalize the numbers and compare
    [Arguments]    ${expected_int}    ${actual_int}    ${compare_title}=${EMPTY}
    IF    '${expected_int}' == '${EMPTY}'
        Log And Log To Console    Expected ${compare_title}:\n${None}\nActual ${compare_title}:\n${actual_int}
        Should Be Equal As Strings    ${None}    ${actual_int}
    ELSE
        Log And Log To Console    Expected ${compare_title}:\n${expected_int}\nActual ${compare_title}:\n${actual_int}
        ${expected_int}=    Evaluate    '{:.2f}'.format(float(${expected_int}))
        ${actual_int}=    Evaluate    '{:.2f}'.format(float(${actual_int}))
        Should Be Equal    ${expected_int}    ${actual_int}
    END

Compare Date
    [Documentation]    Format date and compare
    [Arguments]    ${expected_date}    ${actual_date}    ${compare_title}=${EMPTY}
    IF    '${expected_date}' == '${EMPTY}'
        Log And Log To Console    Expected ${compare_title}:\n${None}\nActual ${compare_title}:\n${actual_date}
        Should Be Equal As Strings    ${None}    ${actual_date}
    ELSE
        ${expected_date}=    Convert Date    ${expected_date}    result_format=%Y-%m-%d %H:%M:%S.%f
        ${actual_date}=    Convert Date    ${actual_date}    result_format=%Y-%m-%d %H:%M:%S.%f
        Log And Log To Console    Expected ${compare_title}:\n${expected_date}\nActual ${compare_title}:\n${actual_date}
        Should Be Equal    ${expected_date}    ${actual_date}
    END

Validate Json Schema
    [Documentation]    Validate Json Schema
    [Arguments]    ${json_schema_file_name}    ${response_body}
    ${json_schema_str}=    Get File    ./test-data/${json_schema_file_name}.json
    Log And Log To Console    Validating json schema with the response body\njson_schema:\n${json_schema_str}
    Evaluate    jsonschema.validate(instance=${response_body}, schema=${json_schema_str})

Log and Log To Console
    [Arguments]    ${msg}
    Log    \n${msg}
    Log To Console    \n${msg}

Open Browser And Navigate To Login Page
#   Set default download directory to reports/downloads
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs} =    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    ${execution_profile_chrome_name}    options=${chrome_options}
    Log To Console    Navigating to ${login_page}
    Go To    ${login_page}

Click Element With Scroll
    [Arguments]    ${xpath}
    Scroll Element Into View    ${xpath}
    Click Element    ${xpath}

Input Text With Scroll
    [Arguments]    ${xpath}    ${value}
    Scroll Element Into View    ${xpath}
    Input Text    ${xpath}    ${value}

Page Should Contain Element With Scroll
    [Arguments]    ${xpath}
    Scroll Element Into View    ${xpath}
    Page Should Contain Element    ${xpath}

Click Element With Scroll And Retry
    [Arguments]    ${xpath}
    Wait Until Keyword Succeeds    10x    50ms    Click Element With Scroll    ${xpath}

Input Text With Scroll And Retry
    [Arguments]    ${xpath}    ${value}
    Wait Until Keyword Succeeds    10x    50ms    Input Text With Scroll    ${xpath}    ${value}

Page Should Contain Element With Scroll And Retry
    [Arguments]    ${xpath}
    Wait Until Keyword Succeeds    10x    50ms    Page Should Contain Element With Scroll    ${xpath}
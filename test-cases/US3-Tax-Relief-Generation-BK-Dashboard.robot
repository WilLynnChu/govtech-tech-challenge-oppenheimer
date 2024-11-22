*** Settings ***
Documentation       Test Suite for User Stories 3 Book Keeper Dashboard
Resource            ../keywords/bk.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown


*** Test Cases ***
Test Case 1 - Book Keeper Dashboard Generate Tax Relief File - Positive
    ${test_start_date_time}=    Get Current Date    UTC    8 hours    result_format=%Y-%m-%d %H:%M:%S.%f
    Set Test Variable    ${test_start_date_time}
    Setup Book Keeper Clear DB Data
    Open Browser And Navigate To Login Page
    Login As Book Keeper
    Generate Tax Relief File
    Verify Tax Relief File
    Verify DB File Table
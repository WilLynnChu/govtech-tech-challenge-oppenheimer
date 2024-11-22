*** Settings ***
Documentation       Test Suite for User Stories 1 Create Hero API
Resource            ../keywords/working-class-heroes.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Library             DataDriver    file=./test-data/US1-data.csv    dialect=unix
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown

*** Test Cases ***
${test_case_name}
    [Template]    Test Template US1

*** Keywords ***
Test Template US1
    [Arguments]    ${test_case_name}    ${flow}    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${expectedStatus}    ${expectedErrMessage}
    Setup Working Class Heroes Clear DB Data    ${natid}
    ${create_hero_response}=    Create Hero API    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${expected_status}
    Verify Create Hero API Response Message    ${create_hero_response}    ${flow}    ${expectedErrMessage}
    Verify Created Hero Against DB    ${natid}    ${create_hero_response}

*** Settings ***
Documentation       Test Suite for User Stories 4 Create Hero Vouchers API
Resource            ../keywords/working-class-heroes.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Library             DataDriver    file=./test-data/US4-data.csv    dialect=unix
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown

*** Test Cases ***
${test_case_name}
    [Template]    Test Template US4

*** Keywords ***
Test Template US4
    [Arguments]    ${test_case_name}    ${flow}    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${vouchers:voucherName}    ${vouchers:voucherType}    ${expectedStatus}    ${expectedErrMessage}
    Setup Working Class Heroes With Voucher Clear DB Data    ${natid}
    ${create_hero_response}=    Create Hero With Voucher API    ${natid}    ${name}    ${gender}    ${birthDate}    ${deathDate}    ${salary}    ${taxPaid}    ${browniePoints}    ${vouchers:voucherName}    ${vouchers:voucherType}    ${expected_status}
    Verify Create Hero With Voucher API Response Message    ${create_hero_response}    ${flow}    ${expectedErrMessage}
    Verify Created Hero Against DB    ${natid}    ${create_hero_response}
    Verify Voucher Created Against DB    ${natid}    ${vouchers:voucherName}    ${vouchers:voucherType}

*** Settings ***
Documentation       Keyword file for Vouchers
Library             SeleniumLibrary
Library             Collections
Library             RequestsLibrary
Library             json
Resource            ../object-repo/apiObject.robot
Resource            ../keywords/generic.robot

*** Keywords ***
Get Voucher By Person And Type API
    [Documentation]    Calling Get Request To Get Voucher Sorted By Person Name and Voucher Type
    Log And Log To Console    \n\nCalling API To Get Voucher By Person Name And Voucher Type ${get_voucher_by_person_type_api}\n
    ${response}=    GET    ${get_voucher_by_person_type_api}    expected_status=any
    Log And Log To Console    API Response Response:\n\tExpected Status Code:200\n\tActual Status Code: ${response.status_code}\n\tResponse Body: ${response.text}\n\n
    Should Be Equal As Strings    200    ${response.status_code}
    [Return]    ${response}
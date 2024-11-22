*** Settings ***
Documentation       Test Suite for User Stories 6 Get Voucher By Person And Type API
Resource            ../keywords/vouchers.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown

*** Variables ***
${json_schema_file_name}    US6-json-schema

*** Test Cases ***
Get And Verify Json Schema of Voucher By Person And Type API - Positive
    ${response}=    Get Voucher By Person And Type API
    Validate Json Schema    ${json_schema_file_name}    ${response.json()}
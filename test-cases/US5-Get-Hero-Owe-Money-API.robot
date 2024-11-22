*** Settings ***
Documentation       Test Suite for User Stories 5 Get Hero Owe Money API
Resource            ../keywords/working-class-heroes.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown

*** Variables ***
${json_schema_file_name}    US5-json-schema

*** Test Cases ***
Get Hero Owe Money API - Positive
    [Documentation]    Testing the positive flow of the get hero owe money api and validate the json schema
    ${response}=    Get Hero Owe Money API    natid-1    200
    Validate Json Schema    ${json_schema_file_name}    ${response.json()}

Get Hero Owe Money API - Negative
    [Documentation]    Testing the negative flow of the get hero owe money api by providing non number natid
    ${response}=    Get Hero Owe Money API    natid-a    500
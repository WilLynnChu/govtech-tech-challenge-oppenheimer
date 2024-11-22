*** Settings ***
Documentation       Test Suite for User Stories 2 Clerk Dashboard
Resource            ../keywords/clerk.robot
Resource            ../keywords/generic.robot
Library             SeleniumLibrary
Suite Setup         Suite Setup Clean Reports
Test Teardown       Common Test Teardown

*** Variables ***
${positive_test_data_path}    ${EXECDIR}/test-data/US2-data-positive.csv
${negative_test_data_path}    ${EXECDIR}/test-data/US2-data-negative.csv
${negative_driver_test_data_path}    ${EXECDIR}/test-data/US2-data-negative-driver.csv

*** Test Cases ***
Test Case 1 - Clerk Dashboard Create Heroes Upload CSV File - Positive
    Open Browser And Navigate To Login Page
    Setup Clerk Clear DB Data    ${positive_test_data_path}
    Login As Clerk
    Upload CSV Files Via Clerk Dashboard    ${positive_test_data_path}    Positive
    Verify Uploaded Data In DB    ${positive_test_data_path}

Test Case 2 - Clerk Dashboard Create Heroes Upload CSV File - Negative - Partial Data Wrong Format
    Open Browser And Navigate To Login Page
    Setup Clerk Clear DB Data    ${negative_test_data_path}
    Login As Clerk
    Upload CSV Files Via Clerk Dashboard    ${negative_test_data_path}    Negative

Test Case 3 - Partial Data Wrong Format - Positive
    Verify Partial Uploaded Data In DB    ${negative_test_data_path}    Positive    natid-150
    Verify Partial Uploaded Data In DB    ${negative_test_data_path}    Positive    natid-151

Test Case 4 - Partial Data Wrong Format - Negative - name
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-152

Test Case 5 - Partial Data Wrong Format - Negative - gender - Missing
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-153

Test Case 6 - Partial Data Wrong Format - Negative - birth_date
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-154

Test Case 7 - Partial Data Wrong Format - Negative - salary
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-155

Test Case 8 - Partial Data Wrong Format - Negative - tax_paid
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-156

Test Case 9 - Partial Data Wrong Format - Positive - positive records before negative will still be created
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Positive    natid-157

Test Case 10 - Partial Data Wrong Format - Negative - gender - Wrong Format
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Negative    natid-158

Test Case 11 - Partial Data Wrong Format - Positive - positive records after negative will still be created
    Verify Partial Uploaded Data In DB    ${negative_driver_test_data_path}    Positive    natid-159
# Setting up the environment

## Installing Python and packages

##### 1. Install [Python](https://www.python.org/downloads/)
##### 2. Add the path into your shell profile
```
alias python='/usr/local/bin/python3'
```
##### 3. Check the default python used
```
which python
```
#### Setting up PyCharm
##### 4. Install [PyCharm](https://www.jetbrains.com/pycharm/)
##### 5. Open the project
##### 6. Go to PyCharm preferences and search for Python Interpreter
##### 7. Select/add your Python interpreter. In my case, it is as below
```
Adding existing interpreter at this path /usr/local/bin/python3
```
##### 8. If the correct interpreter is added, the packages that you had installed at step 4 will be shown
##### 9. Go to PyCharm preferences and go to plugin
##### 10. (OPTIONAL) Search and install Hyper RobotFramework Support
#### Setting up Chromedriver
##### 11. Check your Chrome version
##### 12. Download the respective version of [Chromedriver](https://chromedriver.chromium.org/downloads)
##### 13. Extract and replace chromedriver in this path <RepoName>/drivers/chromedriver

# To execute test suite created:
##### 1. Open project with PyCharm
##### 2. In the built in terminal in PyCharm, make sure you are in the root of the project folder 
##### 3. Run below command to grant permission to the shell script
```
chmod +x ./scripts/run_test_venv.sh
```
##### 4. In the terminal, run this command with robot file that you want to run. The shell script will create virtual environment and install dependencies/package. Running from terminal allow us to specify where would the reports/output saved in. In this case, it will be saved in reports. Alternatively you can run from the UI by opening the tests file and clicking the run button beside test case.
```
./scripts/run_test_venv.sh US1
```

# Test Reports
##### If the test is run using the command, it will be stored in PROJECT_DIRECTORY/reports
##### The sample test evidence of the passing test run are stored PROJECT_DIRECTORY/test-archives

# Issue Found
## User Story 1 - Create Hero API:
### Test Case 6 - Positive - Death Date Not Null
    Request Payload:
    {"natid": "natid-16", "name": "Sasha Tan", "gender": "FEMALE", "birthDate": "1996-01-01T23:59:59", "deathDate": "2020-01-01T23:59:59", "salary": "1000.00", "taxPaid": "10.00", "browniePoints": null}

    Response Payload:
    {"timestamp":1732248765350,"status":500,"error":"Internal Server Error","path":"/api/v1/hero"}

    Expected Result:
    Created Hero Successfully with Status Code 200

    Actual Result:
    Status Code 500

### Test Case 17 - Negative - Death Date - Wrong Format
    Request Payload:
    {"natid": "natid-27", "name": "John Cena", "gender": "MALE", "birthDate": "1996-01-01T23:59:59", "deathDate": "2020-21-01T23:59:59", "salary": "1000.00", "taxPaid": "10.00", "browniePoints": null}

    Response Payload:
    {"timestamp":1732248765801,"status":500,"error":"Internal Server Error","path":"/api/v1/hero"}

    Expected Result:
    Status Code 400 with response:
    {"errorMsg":"Invalid deathdate format","timestamp":"2024-11-22T12:12:45.714864"}
    
    Actual Result:
    Status Code 500 with response:
	{"timestamp":1732248765801,"status":500,"error":"Internal Server Error","path":"/api/v1/hero"}

### Test Case 21 - Negative - Tax Paid - Negative Number
    Request Payload:
    {"natid": "natid-31", "name": "John Cena", "gender": "MALE", "birthDate": "1996-01-01T23:59:59", "deathDate": null, "salary": "1000.00", "taxPaid": "-10.00", "browniePoints": null}

    Response Payload:
    {"errorMsg":"must be greater than or equal to 0","timestamp":"2024-11-22T12:12:45.940335"}

    Expected Result:
    errorMsg: Tax paid must be greater than or equals to zero
    
    Actual Result:
    errorMsg is not consistence with other field validation such as salary negative number
    errorMsg: must be greater than or equal to 0
    
## User Story 2 - Create Hero Clerk Dashboard:
###  Test Case 4 - Partial Data Wrong Format - Negative - name
    Expected Result:
    Record should not be created in DB
    
    Actual Result:
    Record created with invalid column named "name": Hanks123@!

###  Test Case 5 - Partial Data Wrong Format - Negative - gender - Missing
    Expected Result:
    Record should not be created in DB
    
    Actual Result:
    Record created with invalid column named "gender": None

###  Test Case 6 - Partial Data Wrong Format - Negative - birth_date
    Expected Result:
    Record should not be created in DB
    
    Actual Result:
    Record created with invalid column named "birth_date": 4000-01-01 23:59:59

###  Test Case 7 - Partial Data Wrong Format - Negative - salary
    Expected Result:
    Record should not be created in DB
    
    Actual Result:
    Record created with invalid column named "salary": -1000.0

###  Test Case 8 - Partial Data Wrong Format - Negative - tax_paid
    Expected Result:
    Record should not be created in DB
    
    Actual Result:
	Record created with invalid column named "tax_paid": -10.0

###  Test Case 9 - Partial Data Wrong Format - Positive - positive records before negative will still be created
    Expected Result:
    Positive record that is one row above the invalid record should be created succenssfully in DB 
    
    Actual Result:
    natid-157 not created in DB

###  Test Case 11 - Partial Data Wrong Format - Positive - positive records after negative will still be created
    Expected Result:
    Positive record that is one row after the invalid record should be created succenssfully in DB
    
    Actual Result:
    natid-159 not created in DB

## User Story 3 - Tax Relief Generation BK Dashboard:
### Test Case 1 - Book Keeper Dashboard Generate Tax Relief File - Positive
    Expected Result:
    Generated file in file table should change status to COMPLETED
    
    Actual Result:
	the status is NEW instead of COMPLETED
    
## User Story 4 - Create Hero With Voucher API
### Test Case 9 - Negative - Natid - Number Above 9999999
    Request Payload:
    {"natid": "natid-9999999990", "name": "Beatrice", "gender": "FEMALE", "birthDate": "1996-02-01T23:59:59", "deathDate": null, "salary": "1001.00", "taxPaid": "11.00", "browniePoints": null, "vouchers": [{"voucherName": "VOUCHER 9", "voucherType": "TRAVEL"}]}
    
    Expected Result:
    Following US1, it should fail validation with status code 400 and unable to create the hero. 
    
    Actual Result:
	Status code 200 and created hero with invalid natid number length in DB

### Test Case 12 - Negative - Name - More than 100 characters
    Request Payload:
    {"natid": "natid-63", "name": "Jennifer Lopez Jennifer Lopez Jennifer Lopez Jennifer Lopez Jennifer Lopez Jennifer Lopez Jennifer Lopez", "gender": "FEMALE", "birthDate": "1996-02-01T23:59:59", "deathDate": null, "salary": "1001.00", "taxPaid": "11.00", "browniePoints": null, "vouchers": [{"voucherName": "VOUCHER 12", "voucherType": "FOOD"}]}
    
    Expected Result:
    Following US1, it should fail validation with status code 400 and unable to create the hero.
    
    Actual Result:
    Status code 200 and created hero with invalid character length in name in DB

## User Story 5 - Get Hero Owe Money API
### Test Case 1 - Get Hero Owe Money API - Positive
    Expected Result:
    Expected Status Code:200

    Actual Result:
	Status code 400 with response:
	{"errorMsg":"Unable to trigger api call","timestamp":"2024-11-22T12:18:57.762166"}
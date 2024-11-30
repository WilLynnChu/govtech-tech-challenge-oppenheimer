# Setting up the environment

#### Installing Java

##### 1. Install [Java](https://www.oracle.com/java/technologies/downloads/?er=221886)
##### 2. Add the path into your bash profile
```
JAVA_HOME="<path_to_java>/bin"
```
##### 3. Check if Java installed and path exported successfully
```
java -version
```
#### Installing Maven
##### 4. Install [Maven](https://maven.apache.org/download.cgi)
##### 5. Add the path into your bash profile
```
export M2_HOME=<path_to_maven>
export PATH=$PATH:/<path_to_maven>/bin
```
##### 6. Dependencies will be managed in maven dependencies and auto download and add the JAR file to Java path.
#### Installing Eclipse
##### 7. Install [Eclipse](https://www.eclipse.org/downloads/)
#### Installing TestNG plugin in Eclipse
##### 8. Copy Online Update-Site link for latest release
##### 9. In Eclipse, go to Help > Install new software
##### 10. In install software window, click Work with > Add/
##### 11. Go to [TestNG plugin](https://github.com/testng-team/testng-eclipse)
##### 12. Set name as TestNG, and set URL as Online Update-Site link copied in step 8
##### 13. Wait for it to install, click accept/agree if needed
##### 14. Restart Eclipse

# To execute test suite created:
##### 1. Open project with Eclipse
##### 2. Right click run_all.xml and run as TestNG
##### 3. Or you can run the individual file in test-cases folder

# Test Reports
##### It will be stored in test-output folder

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

package testCases;


import keywords.GenericKeywords;
import keywords.WorkingClassHeroes;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.testng.annotations.DataProvider;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class US1CreateHeroAPI extends WorkingClassHeroes{
	
	static String test_data_file_name = "/US1-data.csv";
	
	@BeforeTest
	public void testSetUp() {
		GenericKeywords.clearTestOutput(GenericKeywords.test_output_path);
	}
	
	@DataProvider(name = "csvDataProvider")
    public Iterator<Object[]> getCsvData() throws IOException {
        String csvFilePath = GenericKeywords.test_data_path + test_data_file_name; // Update with your CSV file path
        List<Object[]> data = new ArrayList<>();

        try (FileReader fileReader = new FileReader(csvFilePath);
             CSVParser csvParser = new CSVParser(fileReader, CSVFormat.DEFAULT.withHeader())) { // Use this to set the first row as header

            for (CSVRecord record : csvParser) {
                String testCaseName = record.get("${test_case_name}"); // Use the header column name
                // Add other columns as needed
                data.add(new Object[]{testCaseName, record});
            }
        }

        return data.iterator();
    }

    @Test(dataProvider = "csvDataProvider")
    public void US1testWithCsvData(String testCaseName, CSVRecord record) {
        System.out.println("Running test: " + testCaseName);
        String natid = record.get("${natid}");
        String flow = record.get("${flow}");
        String name = record.get("${name}");
        String gender = record.get("${gender}");
        String birthDate = record.get("${birthDate}");
        String deathDate = record.get("${deathDate}");
        String salary = record.get("${salary}");
        String taxPaid = record.get("${taxPaid}");
        String browniePoints = record.get("${browniePoints}");
        String expectedStatus = record.get("${expectedStatus}");
        String expectedErrMessage = record.get("${expectedErrMessage}");
        
        setupWorkingClassHeroesClearDBData(natid);
        String responseBody = createHeroAPI(natid, name, gender, birthDate, deathDate, salary, taxPaid, browniePoints, expectedStatus);   
        verifyCreateHeroAPIResponseMessage(responseBody, expectedErrMessage, flow);
        verifyCreatedHeroAgainstDB(natid, flow);
    }
}

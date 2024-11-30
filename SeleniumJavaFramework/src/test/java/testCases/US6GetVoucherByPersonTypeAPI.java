package testCases;

import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import keywords.GenericKeywords;
import keywords.Voucher;

public class US6GetVoucherByPersonTypeAPI extends Voucher{

	static String json_schema_file_name = "/US6-json-schema.json";
			
	@BeforeTest
	public void testSetUp() {
		GenericKeywords.clearTestOutput(GenericKeywords.test_output_path);
	}
	
	@Test(description = "Test Case 1 - Get And Verify Json Schema of Voucher By Person And Type API - Positive")
	public void US6testCase1() {
		String responseBody = getVoucherByPersonAndTypeAPI("200");
		GenericKeywords.validateJsonSchema(json_schema_file_name, responseBody);
	}
}

package testCases;

import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import keywords.GenericKeywords;
import keywords.WorkingClassHeroes;

public class US5GetHeroOweMoneyAPI extends WorkingClassHeroes{

	static String json_schema_file_name = "/US5-json-schema.json";
	
	@BeforeTest
	public void testSetUp() {
		GenericKeywords.clearTestOutput(GenericKeywords.test_output_path);
	}
	
	@Test(description = "Test Case 1 - Get Hero Owe Money API - Positive")
	public void US5testCase1() {
		String responseBody = getHeroOweMoneyAPI("natid-1", "200");
		GenericKeywords.validateJsonSchema(json_schema_file_name, responseBody);
	}
	
	@Test(description = "Test Case 2 - Get Hero Owe Money API - Negative")
	public void US5testCase2() {
		getHeroOweMoneyAPI("natid-a", "500");
	}
}

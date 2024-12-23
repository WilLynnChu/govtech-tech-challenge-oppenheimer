package testCases;

import org.openqa.selenium.WebDriver;
import org.testng.annotations.*;

import keywords.BookKeeper;
import keywords.GenericKeywords;
import keywords.Login;
import keywords.SQLHelper;

public class US3TaxReliefGenerationBKDashboard extends BookKeeper{

	public static String test_time;
	public static WebDriver driver;
	String role = "Book Keeper";
	
	@BeforeTest
	public void testSetUp() {
		GenericKeywords.clearTestOutput(GenericKeywords.test_output_path);
		test_time = GenericKeywords.testCurrentDateTime();
		driver = GenericKeywords.startWebDriver();
		
	}
	
	@Test
	public void US3testCase1() {
		SQLHelper.queryDatabaseAndReturnResult("delete_file_by_status", null);
		Login.OpenBrowserAndLogin(driver, role);
		generateTaxReliefFile(driver);
		verifyTaxReliefFileContent();
		verifyDBFileTable(test_time);
	}
	
	@AfterTest
	public void testTearDown() {
		GenericKeywords.quitWebDriver(driver);
	}
}

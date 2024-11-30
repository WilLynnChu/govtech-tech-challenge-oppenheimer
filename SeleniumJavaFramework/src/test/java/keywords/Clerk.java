package keywords;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.Sleeper;

import com.mysql.cj.log.Log;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertNull;

import java.io.IOException;
import java.lang.System.Logger;
import java.util.List;
import java.util.Map;
import objectRepository.APIObject;
import objectRepository.ClerkObject;
import objectRepository.LoginObject;

public class Clerk extends ClerkObject{

    public static List<List<String>> setupClerkClearDBData(String filepath) {
    	
    	List<List<String>> csvContent = CSVReader.readCSVWithoutHeader(filepath);
    	System.out.println("\n\n\nCSV CONTENT: \n" + csvContent + "\n\n\n");
    	clearClerkDBFromCSV(csvContent, 0);
    	return csvContent;
    }

    public static void clearClerkDBFromCSV(List<List<String>> csvData, int columnIndex) {
    	
        if (csvData.isEmpty()) {
            System.out.println("No data to display.");
            return;
        }
        for (List<String> row : csvData) {
            if (columnIndex >= 0 && columnIndex < row.size()) {
            	Map<String, String> sql_dict = SQLHelper.createSQLDictionary();
            	sql_dict = SQLHelper.addToSQLDictionary(sql_dict, "value_natid", row.get(columnIndex));
            	SQLHelper.queryDatabaseAndReturnResult("delete_hero_by_natid", sql_dict);
            }
        }
    }
    
    public static void uploadCSVFilesViaClerkDashboard(WebDriver driver, String filepath, String flow) {
    	
    	System.out.println("Upload CSV files from clerk dashboard to create heroes");
    	if (lbl_header_clerk(driver).isDisplayed()) {
    		btn_add_hero_clerk(driver).click();
    		dropdown_option_upload_csv_clerk(driver).click();
    	}
    	System.out.println("Uploading CSV Files From Path " + filepath);
    	if (input_upload_csv_file_clerk(driver).isDisplayed()) {
    		input_upload_csv_file_clerk(driver).sendKeys(filepath);
    	}
    	btn_create_clerk(driver).click();
    	if (flow.equals("Positive")) {
    		lbl_created_success_clerk(driver).isDisplayed();
        	System.out.println("Upload successfully");
    	} else {
			lbl_created_unsuccess_warning_clerk(driver).isDisplayed();
	    	System.out.println("Upload failed with warning");
		}
    }
    
    public static void verifyUploadedDataInDB(List<List<String>> csvContent) {
    	
        for (List<String> row : csvContent) {
        	Map<String, String> sql_dict = SQLHelper.createSQLDictionary();
        	sql_dict = SQLHelper.addToSQLDictionary(sql_dict, "value_natid", row.get(0));
        	List<Map<String, Object>> sql_response = SQLHelper.queryDatabaseAndReturnResult("select_hero_by_natid", sql_dict);
        	Map<String, Object> selected_hero = sql_response.get(0);
        	selected_hero = GenericKeywords.replaceNullInMap(selected_hero);
        	Object actual_natid = selected_hero.get("natid");
        	Object actual_name = selected_hero.get("name");
        	Object actual_gender = selected_hero.get("gender");
        	Object actual_birth_date = selected_hero.get("birth_date");
        	Object actual_death_date = selected_hero.get("death_date");
        	Object actual_salary = selected_hero.get("salary");
        	Object actual_tax_paid = selected_hero.get("tax_paid");
        	Object actual_brownie_points = selected_hero.get("brownie_points");
        	System.out.println("expected_natid: " + row.get(0));
        	System.out.println("actual_natid: " + actual_natid);
        	System.out.println("expected_name: " + row.get(1));
        	System.out.println("actual_name: " + actual_name);
        	System.out.println("expected_gender: " + row.get(2));
        	System.out.println("actual_gender: " + actual_gender);
        	System.out.println("expected_birth_date: " + row.get(3));
        	System.out.println("actual_birth_date: " + actual_birth_date);
        	System.out.println("expected_death_date: " + row.get(4));
        	System.out.println("actual_death_date: " + actual_death_date);
        	System.out.println("expected_salary: " + row.get(5));
        	System.out.println("actual_salary: " + actual_salary);
        	System.out.println("expected_tax_paid: " + row.get(6));
        	System.out.println("actual_tax_paid: " + actual_tax_paid);
        	System.out.println("expected_brownie_points: " + row.get(7));
        	System.out.println("actual_brownie_points: " + actual_brownie_points);
        	assertEquals(actual_natid.toString(), row.get(0).toString());
        	assertEquals(actual_name.toString(), row.get(1).toString());
        	assertEquals(actual_gender.toString(), row.get(2).toString());
        	assertEquals(actual_birth_date.toString(), row.get(3).toString());
        	assertEquals(actual_death_date.toString(), row.get(4).toString());
        	GenericKeywords.assertDecimals(actual_salary.toString(), row.get(5).toString());
        	GenericKeywords.assertDecimals(actual_tax_paid.toString(), row.get(6).toString());
        	GenericKeywords.assertDecimals(actual_brownie_points.toString(), row.get(7).toString());
        }
    }
    
    public static void verifyPartialUploadedDataInDB(List<List<String>> csvContent, String flow, String natid) {
    	Map<String, String> sql_dict = SQLHelper.createSQLDictionary();
    	sql_dict = SQLHelper.addToSQLDictionary(sql_dict, "value_natid", natid);
    	List<Map<String, Object>> sql_response = SQLHelper.queryDatabaseAndReturnResult("select_hero_by_natid", sql_dict);
    	if (flow.equals("Positive")) {
    		boolean pass_status = false;

    		if (!sql_response.isEmpty()) {
	        	Map<String, Object> selected_hero = sql_response.get(0);
	            for (List<String> row : csvContent) {
	            	Object actual_natid = selected_hero.get("natid");
	            	if (row.get(0).equals(actual_natid)) {
	            		pass_status = true;
	            		selected_hero = GenericKeywords.replaceNullInMap(selected_hero);
	                	Object actual_name = selected_hero.get("name");
	                	Object actual_gender = selected_hero.get("gender");
	                	Object actual_birth_date = selected_hero.get("birth_date");
	                	Object actual_death_date = selected_hero.get("death_date");
	                	Object actual_salary = selected_hero.get("salary");
	                	Object actual_tax_paid = selected_hero.get("tax_paid");
	                	Object actual_brownie_points = selected_hero.get("brownie_points");
	                	System.out.println("expected_natid: " + row.get(0));
	                	System.out.println("actual_natid: " + actual_natid);
	                	System.out.println("expected_name: " + row.get(1));
	                	System.out.println("actual_name: " + actual_name);
	                	System.out.println("expected_gender: " + row.get(2));
	                	System.out.println("actual_gender: " + actual_gender);
	                	System.out.println("expected_birth_date: " + row.get(3));
	                	System.out.println("actual_birth_date: " + actual_birth_date);
	                	System.out.println("expected_death_date: " + row.get(4));
	                	System.out.println("actual_death_date: " + actual_death_date);
	                	System.out.println("expected_salary: " + row.get(5));
	                	System.out.println("actual_salary: " + actual_salary);
	                	System.out.println("expected_tax_paid: " + row.get(6));
	                	System.out.println("actual_tax_paid: " + actual_tax_paid);
	                	System.out.println("expected_brownie_points: " + row.get(7));
	                	System.out.println("actual_brownie_points: " + actual_brownie_points);
	                	assertEquals(actual_natid.toString(), row.get(0).toString());
	                	assertEquals(actual_name.toString(), row.get(1).toString());
	                	assertEquals(actual_gender.toString(), row.get(2).toString());
	                	assertEquals(actual_birth_date.toString(), row.get(3).toString());
	                	assertEquals(actual_death_date.toString(), row.get(4).toString());
	                	GenericKeywords.assertDecimals(actual_salary.toString(), row.get(5).toString());
	                	GenericKeywords.assertDecimals(actual_tax_paid.toString(), row.get(6).toString());
	                	GenericKeywords.assertDecimals(actual_brownie_points.toString(), row.get(7).toString());
	            	}
	            }
            } else {
            	throw new AssertionError("Positive Record Not Created In DB");
            }
    	} else {
    		if (!sql_response.isEmpty()) {
    			for (List<String> row : csvContent) {
        			if (row.get(0).equals(natid)) {
        				throw new AssertionError("Negative Record With Invalid Column Named \"" + row.get(2) + "\" Should Not Be Created In DB");
        			}
        		}
    		}
    		
    	}
    	
    }
}
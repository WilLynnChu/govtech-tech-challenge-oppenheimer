package objectRepository;

import java.time.Duration;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import keywords.GenericKeywords;
import net.bytebuddy.description.type.TypeDescription.Generic;

public class ClerkObject {

	static WebElement element = null;
	
	public static WebElement btn_add_hero_clerk(WebDriver driver) {

		By locator = By.id("dropdownMenuButton2");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement btn_create_clerk(WebDriver driver) {
		By locator = By.xpath("//button[normalize-space()='Create']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

	public static WebElement dropdown_option_upload_csv_clerk(WebDriver driver) {

		By locator = By.xpath("//a[@class='dropdown-item' and text()='Upload a csv file']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

	public static WebElement lbl_header_clerk(WebDriver driver) {

		By locator = By.xpath("//h1[normalize-space()='Clerk Dashboard']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement lbl_created_success_clerk(WebDriver driver) {

		By locator = By.xpath("//div[@class='bg-success pt-2']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement lbl_created_unsuccess_warning_clerk(WebDriver driver) {

		By locator = By.xpath("//div[@class='bg-warning pt-2']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

	public static WebElement input_upload_csv_file_clerk(WebDriver driver) {

		By locator = By.id("upload-csv-file");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

}
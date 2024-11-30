package objectRepository;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import keywords.GenericKeywords;

public class LoginObject {
	
	static WebElement element = null;
	
	public static WebElement btn_submit_login(WebDriver driver) {
		By locator = By.xpath("//input[@type='submit']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

	public static WebElement lbl_header_login(WebDriver driver) {
		By locator = By.xpath("//h1[normalize-space()='Working Class Hero System']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}

	public static WebElement input_username_login(WebDriver driver) {
		
		By locator = By.id("username-in");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement input_password_login(WebDriver driver) {
		
		By locator = By.id("password-in");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
}

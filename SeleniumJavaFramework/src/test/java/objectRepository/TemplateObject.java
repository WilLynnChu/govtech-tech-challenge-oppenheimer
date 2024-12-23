package objectRepository;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import keywords.GenericKeywords;

public class TemplateObject {
	
	static WebElement element = null;
	
	public static WebElement btn_name_page(WebDriver driver) {
		
		By locator = By.id("id");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement lbl_name_page(WebDriver driver) {
		
		By locator = By.xpath("xpath");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
}

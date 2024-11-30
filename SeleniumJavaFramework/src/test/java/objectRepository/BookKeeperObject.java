package objectRepository;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import keywords.GenericKeywords;

public class BookKeeperObject {

	static WebElement element = null;
	
	public static WebElement btn_generate_tax_relief_clerk(WebDriver driver) {
		
		By locator = By.id("tax_relief_btn");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
	
	public static WebElement lbl_header_bk(WebDriver driver) {
		
		By locator = By.xpath("//h1[normalize-space()='Book Keeper Dashboard']");
		element = GenericKeywords.pageShouldContainElement(driver, locator);
		return element;
	}
}

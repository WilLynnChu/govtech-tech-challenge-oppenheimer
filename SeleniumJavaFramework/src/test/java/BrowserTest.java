import java.nio.file.Path;
import java.nio.file.Paths;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class BrowserTest {

	public static void main(String[] args) {
		
//		Get Driver Path
		Path projectPath = Paths.get("").toAbsolutePath();
        Path driversPath = projectPath.resolve("drivers");
        
        System.setProperty("webdriver.chrome.driver", driversPath.resolve("chromedriver").toString());
        WebDriver driver = new ChromeDriver();
        
		driver.get("https://www.google.com");
		driver.get("https://www.seleniumhq.org");
		driver.close();
	}
}

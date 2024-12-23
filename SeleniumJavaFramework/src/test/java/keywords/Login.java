package keywords;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import java.io.IOException;
import java.util.Map;
import objectRepository.APIObject;
import objectRepository.LoginObject;

public class Login extends LoginObject{

    public static void OpenBrowserAndLogin(WebDriver driver, String role) {
        driver.get(APIObject.base_url + "/login");
        
        try {
            // Get credentials for the specified role
            Map<String, String> credentials = CSVReader.getLoginCredentials(role, GenericKeywords.test_data_path + "/role-credential.csv");
//            Thread.sleep(10000);
            if (!credentials.isEmpty()) {
                // Find elements and perform login actions
                if (lbl_header_login(driver).isDisplayed()) {
                    input_username_login(driver).sendKeys(credentials.get("username"));
                    input_password_login(driver).sendKeys(credentials.get("password"));
                    btn_submit_login(driver).click();
                }
            } else {
                System.out.println("Credentials not found for the specified role.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

package keywords;

import java.io.IOException;
import java.io.OutputStream;

import static org.testng.Assert.assertEquals;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import org.apache.hc.client5.http.classic.HttpClient;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.HttpClientBuilder;
import org.apache.hc.core5.http.HttpResponse;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dev.failsafe.internal.util.Assert;
import objectRepository.APIObject;

public class Voucher {

	public static String getVoucherByPersonAndTypeAPI(String expectedStatus) {
		String requestBody = APIHelper.getAPI(APIObject.get_voucher_by_person_type_api, expectedStatus);
		return requestBody;
	}
}

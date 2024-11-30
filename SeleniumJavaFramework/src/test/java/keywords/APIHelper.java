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

public class APIHelper {

	public static String convertDictToJsonString(Map<String, String> dictPayload) {
		// Convert the Map to JSON
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonString = objectMapper.writeValueAsString(dictPayload);
            jsonString = jsonString.replaceAll("\"null\"", "null");
            jsonString = jsonString.replaceAll("\\\\", "");
            jsonString = jsonString.replaceAll("\"\\[", "[");
            jsonString = jsonString.replaceAll("\\]\"", "]");
            System.out.println("JSON Output: " + jsonString);
            return jsonString;
        } catch (Exception e) {
            e.printStackTrace();
            return e.toString();
        }
	}

    public static String getAPI(String endpoint, String expectedStatus) {
    	
    	try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            HttpGet request = new HttpGet(endpoint);
            System.out.println("Endpoint: " + endpoint);
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                if (response.getEntity() != null) {
                    // Read the response body
                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(response.getEntity().getContent()));
                    StringBuilder responseBody = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        responseBody.append(line);
                    }
	          	    System.out.println("Expected Response Status Code: " + expectedStatus);
	          	    System.out.println("Actual Response Status Code: " + response.getCode());
                    String responseBodyString = responseBody.toString();
                    System.out.println("Response Body: " + responseBodyString);
                	assertEquals(String.valueOf(response.getCode()), expectedStatus);
                	return responseBodyString;
                } else {
                	String message_string = "No response body received.";
                    System.out.println(message_string);
                    return message_string;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
    		return e.toString();
        }
    }
    
    public static String postAPI(String endpoint, String jsonPayload, String expectedStatus) {
    	
    	try (CloseableHttpClient httpClient = HttpClientBuilder.create().build()) {
            // Create HttpPost request
            HttpPost request = new HttpPost(endpoint);
            StringEntity params = new StringEntity(jsonPayload);
            request.addHeader("Content-Type", "application/json");
            request.setEntity(params);

            // Execute the request
            try (CloseableHttpResponse response = httpClient.execute(request)) {
                // Check if there is a response entity
                if (response.getEntity() != null) {
                    // Read the response body
                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(response.getEntity().getContent()));
                    StringBuilder responseBody = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        responseBody.append(line);
                    }
	          	    System.out.println("Expected Response Status Code: " + expectedStatus);
	          	    System.out.println("Actual Response Status Code: " + response.getCode());
                    String responseBodyString = responseBody.toString();
                    System.out.println("Response Body: " + responseBodyString);
                	assertEquals(String.valueOf(response.getCode()), expectedStatus);
                	return responseBodyString;
                } else {
                	String message_string = "No response body received.";
                    System.out.println(message_string);
                    return message_string;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
    		return e.toString();
        }
    }

	public static String extractResponseBodyByKey(String responseBody, String key) {
		try {
            ObjectMapper objectMapper = new ObjectMapper();
            
            // Parse the JSON string
            JsonNode rootNode = objectMapper.readTree(responseBody);
            
            // Extract the "message" field
            if (!responseBody.isEmpty()) {
                System.out.println("Response Body Key (" + key + ") is not empty.");
	            String value = rootNode.get(key).asText(""); // Pass `null` for a default if it's null
	            System.out.println(key + ": " + value); // Outputs "null" or "wrong format"
	            return value;
            } else {
                System.out.println("Response Body Key (" + key + ") is empty.");
            	return responseBody;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }

	}
}

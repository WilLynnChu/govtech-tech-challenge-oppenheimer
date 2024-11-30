package keywords;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;

public class CSVReader {

    public static Map<String, String> getLoginCredentials(String role, String filePath) throws IOException {
        Map<String, String> credentials = new HashMap<>();
        try (CSVParser csvParser = new CSVParser(new FileReader(filePath), CSVFormat.DEFAULT.withHeader())) {
            for (CSVRecord record : csvParser) {
                if (record.get("role").equals(role)) {
                    credentials.put("username", record.get("username"));
                    credentials.put("password", record.get("password"));
                    break;
                }
            }
        }
        return credentials;
    }
    
    public static List<String[]> readCsvFileToList(String filePath) {
        List<String[]> content = new ArrayList<>();
        
        try (BufferedReader br = new BufferedReader(new FileReader(new File(filePath)))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Split the line by commas and add it to the list
                content.add(line.split(","));
            }
        } catch (IOException e) {
        	throw new AssertionError(e.getMessage());
        }
        
        return content;
    }
    
    public static List<List<String>> readCSVWithoutHeader(String filePath) {
        List<List<String>> data = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;

            while ((line = br.readLine()) != null) {
                String[] values = line.split(",", -1); // Split values
                List<String> row = new ArrayList<>();
                for (String value : values) {
                    row.add(value.trim());
                }
                data.add(row);
            }
        } catch (IOException e) {
			throw new AssertionError(e.getMessage());
        }

        return data;
    }
}

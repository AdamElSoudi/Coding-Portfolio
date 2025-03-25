package algo.weatherdata;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;

/**
 * Retrieves temperature data from a weather station file.
 */
public class WeatherDataHandler {
	Map<LocalDate, List<List<String>>> data = new HashMap<>();
	/**
	 * Load weather data from file.
	 * 
	 * @param filePath path to file with weather data
	 * @throws IOException if there is a problem while reading the file
	 */
	public void loadData(String filePath) throws IOException {
		List<String> fileData = Files.readAllLines(Paths.get(filePath));
		for (String line : fileData) {
			String[] dataArr = line.split(";");
			LocalDate date = LocalDate.parse(dataArr[0]);

			if (data.get(date) == null) {
				List<List<String>> listOfLists = new ArrayList<>();
				List<String> list = new ArrayList<>();
				list.add(dataArr[1]);
				list.add(dataArr[2]);
				list.add(dataArr[3]);
				listOfLists.add(list);
				data.put(date, listOfLists);

			}
			else {
				List<String> list = new ArrayList<>();
				list.add(dataArr[1]);
				list.add(dataArr[2]);
				list.add(dataArr[3]);
				data.get(date).add(list);

			}

		}

	}
	/**
	 * Search for average temperature for all dates between the two dates (inclusive).
	 * Result is sorted by date (ascending). When searching from 2000-01-01 to 2000-01-03
	 * the result should be:
	 * 2000-01-01 average temperature: 0.42 degrees Celsius
	 * 2000-01-02 average temperature: 2.26 degrees Celsius
	 * 2000-01-03 average temperature: 2.78 degrees Celsius
	 * 
	 * @param dateFrom start date (YYYY-MM-DD) inclusive  
	 * @param dateTo end date (YYYY-MM-DD) inclusive
	 * @return average temperature for each date, sorted by date  
	 */
	public List<String> averageTemperatures(LocalDate dateFrom, LocalDate dateTo) {

		List<String> averages = new ArrayList<>();
		LocalDate date = dateFrom;

		while (!date.equals(dateTo.plusDays(1))) {
			double sum = 0;

			List<List<String>> listOfLists = data.get(date);
			int n = 0;
			for (List<String> list : listOfLists) {
				sum += Double.parseDouble(list.get(1));
				n++;
			}
			double avarage = sum / n;
			averages.add(date + " average temperature: " + Math.round(avarage*100.0)/100.0 + " degrees Celsius");
			date = date.plusDays(1);
		}
		return averages;
	}
	/**
	 * Search for missing values between the two dates (inclusive) assuming there 
	 * should be 24 measurement values for each day (once every hour). Result is
	 * sorted by number of missing values (descending). When searching from
	 * 2000-01-01 to 2000-01-03 the result should be:
	 * 2000-01-02 missing 1 values
	 * 2000-01-03 missing 1 values
	 * 2000-01-01 missing 0 values
	 * 
	 * @param dateFrom start date (YYYY-MM-DD) inclusive  
	 * @param dateTo end date (YYYY-MM-DD) inclusive
	 * @return dates with missing values together with number of missing values for each date, sorted by number of missing values (descending)
	 */
	public List<String> missingValues(LocalDate dateFrom, LocalDate dateTo) {
		List<String> missing = new ArrayList<>();
		LocalDate date = dateFrom;
		while (!date.equals(dateTo.plusDays(1))) {
			List<List<String>> listOfLists = data.get(date);
			missing.add(date.toString() + " missing " + String.valueOf(24 - listOfLists.size()) + " values");
			date = date.plusDays(1);
		}
		return missing;
	}
	/**
	 * Search for percentage of approved values between the two dates (inclusive).
	 * When searching from 2000-01-01 to 2000-01-03 the result should be:
	 * Approved values between 2000-01-01 and 2000-01-03: 32.86 %
	 * 
	 * @param dateFrom start date (YYYY-MM-DD) inclusive  
	 * @param dateTo end date (YYYY-MM-DD) inclusive
	 * @return period and percentage of approved values for the period  
	 */
	public List<String> approvedValues(LocalDate dateFrom, LocalDate dateTo) {
		List<String> approved = new ArrayList<>();
		LocalDate date = dateFrom;
		double sumApproved = 0;
		double sumTotal = 0;
		while (!date.equals(dateTo.plusDays(1))) {
			List<List<String>> listOfLists = data.get(date);
			for (List<String> list : listOfLists) {
				if (list.get(2).equals("G")) {
					sumApproved++;
				}
				sumTotal++;
			}

			date = date.plusDays(1);
		}
		double percentage = (sumApproved / sumTotal) * 100;
		approved.add("Approved values between " + dateFrom.toString() + " to " + dateTo.toString() + ": " + Math.round(percentage*100.0)/100.0 + "%");
		return approved;
	}
}
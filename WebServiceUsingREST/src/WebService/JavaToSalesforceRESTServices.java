package WebService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Scanner;

import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author Nidhi Sharma Date : 18 feb,2016 Description : This class is to query
 *         salesforce database and insert new student in database
 *
 */
public class JavaToSalesforceRESTServices {
	// Providing login credentials to login to salesforce Oauth
	static final String USERNAME = "nidhi.sharma@salesforce.com";
	static final String PASSWORD = "nidhi8502911608sharma";
	static final String LOGINURL = "https://login.salesforce.com";
	static final String GRANTSERVICE = "/services/oauth2/token?grant_type=password";
	static final String CLIENTID = "3MVG9ZL0ppGP5UrC5.x5K61nnjdppUTPdhQoW1SkSydnLwwgs9NAXbJTm3rWAVPjO7WMW9Ez96JW17BiS2jXb";
	static final String CLIENTSECRET = "4274994355135511396";
	private static String REST_ENDPOINT = "/services/data";
	private static String API_VERSION = "/v32.0";
	private static String baseUri;
	private static Header oauthHeader;
	private static Header prettyPrintHeader = new BasicHeader("X-PrettyPrint",
			"1");
	private static String studentId;

	// Main method
	public static void main(String[] args) throws ParseException, IOException {
		JSONObject authJsonObject = OAuthServlet.oAuthSessionProvider(LOGINURL,
				USERNAME, PASSWORD, CLIENTID, CLIENTSECRET);
		String loginAccessToken = null;
		try {
			loginAccessToken = authJsonObject.getString("access_token");
		} catch (JSONException jsonException) {
			jsonException.printStackTrace();
		}

		baseUri = "https://ap2.salesforce.com" + REST_ENDPOINT + API_VERSION;
		oauthHeader = new BasicHeader("Authorization", "OAuth "
				+ loginAccessToken);
		System.out
				.println("---------------Successfully logged in---------------");
		// Calling methods to execute queries from salesforce database
		retrieveSOQLResults();
		createStudent();
	}

	/**
	 * To retrieve results of specified query using REST HttpGet
	 */
	public static void retrieveSOQLResults() {
		try {
			// Set up the HTTP objects require to make the request.
			HttpClient httpClient = HttpClientBuilder.create().build();
			@SuppressWarnings("resource")
			Scanner scanner = new Scanner(System.in);
			System.out.println("Enter SOQL here");
			String query = scanner.nextLine();
			if (query == null || query.isEmpty()) {
				System.out
						.println("query not entered \n Executing default query to retrieve contacts");
				query = "Select Name from Contact";
			}
			query = query.replaceAll(" ", "+");
			String uri = baseUri + "/query?q=" + query;
			HttpGet httpGet = new HttpGet(uri);
			httpGet.addHeader(oauthHeader);
			httpGet.addHeader(prettyPrintHeader);
			// Make the request
			HttpResponse response = httpClient.execute(httpGet);
			// Process the result
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == 200) {
				String responseString = EntityUtils.toString(response
						.getEntity());
				try {
					JSONObject json = new JSONObject(responseString);
					System.out.println("Query result:\n" + json.toString(1));
					// json.getJSONArray("records");
				} catch (JSONException jsonException) {
					jsonException.printStackTrace();
				}
			} else {
				System.out
						.println("Query was unsuccessful. Status code returned is "
								+ statusCode);
				System.out.println("An error has occured. Http status: "
						+ response.getStatusLine().getStatusCode());
				System.out.println(getBody(response.getEntity().getContent()));
				System.exit(-1);
			}
		} catch (IOException inputOutputException) {
			inputOutputException.printStackTrace();
		} catch (NullPointerException nullException) {
			nullException.printStackTrace();
		}
	}

	/**
	 * Create Student using REST HttpPost
	 */
	public static void createStudent() {
		System.out
				.println("\n--------------------------------Insert New Student--------------------------------");
		String uri = baseUri + "/sobjects/Student__c/";
		try {
			Scanner scanner = new Scanner(System.in);
			// create the JSON object containing the new student details.
			JSONObject student = new JSONObject();
			System.out.println("Enter student details");
			System.out.print("First Name : ");
			// To get student first name
			String firstName = scanner.next();
			System.out.print("Last Name : ");
			// To get student last name
			String lastName = scanner.next();
			String classId;
			System.out
					.println("Select your class : \n 1. V \n 2. VIII \n 3. X");
			Integer choice = scanner.nextInt();
			switch (choice) {
			case 1:
				classId = "a0928000008klKg";
				break;
			case 2:
				classId = "a0928000008lvfk";
				break;
			case 3:
				classId = "a0928000008klKR";
				break;
			default:
				classId = "a0928000008klKR";
				break;
			}
			student.put("FirstName__c", firstName);
			student.put("LastName__c", lastName);
			student.put("Class__c", classId);
			System.out.println("Student to be inserted :\n"
					+ student.toString(1));
			// Construct the objects needed for the request
			HttpClient httpClient = HttpClientBuilder.create().build();
			HttpPost httpPost = new HttpPost(uri);
			httpPost.addHeader(oauthHeader);
			httpPost.addHeader(prettyPrintHeader);
			// The message we are going to post
			StringEntity body = new StringEntity(student.toString(1));
			body.setContentType("application/json");
			httpPost.setEntity(body);
			// Make the request
			HttpResponse response = httpClient.execute(httpPost);
			// Process the results
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == 201) {
				String response_string = EntityUtils.toString(response
						.getEntity());
				JSONObject json = new JSONObject(response_string);
				studentId = json.getString("id");
				System.out
						.println("New Student successfully inserted with id : "
								+ studentId);
			} else {
				System.out
						.println("Insertion unsuccessful. Status code returned is "
								+ statusCode);
			}
			scanner.close();
		} catch (JSONException jsonException) {
			System.out.println("Issue creating JSON or processing results");
			jsonException.printStackTrace();
		} catch (IOException inputOutputException) {
			inputOutputException.printStackTrace();
		} catch (NullPointerException nullPointerException) {
			nullPointerException.printStackTrace();
		}
	}

	private static String getBody(InputStream inputStream) {
		String result = "";
		try {
			BufferedReader inputReader = new BufferedReader(
					new InputStreamReader(inputStream));
			String inputLine;
			while ((inputLine = inputReader.readLine()) != null) {
				result += inputLine;
				result += "\n";
			}
			inputReader.close();
		} catch (IOException inputOutputException) {
			inputOutputException.printStackTrace();
		}
		return result;
	}
}
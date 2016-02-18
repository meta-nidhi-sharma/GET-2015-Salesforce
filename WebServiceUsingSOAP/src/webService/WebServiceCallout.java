package webService;

import java.net.URL;
import java.util.Scanner;
import com.sforce.soap.enterprise.LoginResult;
import com.sforce.soap.enterprise.SessionHeader;
import com.sforce.soap.enterprise.SforceServiceLocator;
import com.sforce.soap.enterprise.SoapBindingStub;
import com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleBindingStub;
import com.sforce.soap.schemas._class.JavaToSalesforceWebServiceExample.JavaToSalesforceWebServiceExampleServiceLocator;

/**
 * @author Nidhi Sharma Date : 17 Feb,2016 Description: This class is used to
 *         make connection to salesforce apex class named
 *         'JavaToSalesforceWebService' and query salesforce database.
 *
 */
public class WebServiceCallout {
	// Main method
	public static void main(String[] args) {
		try {
			// To get a stub for calling enterprise WSDL's login method in order
			// to get SessionID
			SoapBindingStub bind = (SoapBindingStub) new SforceServiceLocator()
					.getSoap();
			LoginResult loginResult = bind.login("nidhi.sharma@salesforce.com",
					"nidhi8502911608sharma");
			// Create a sessionHeader object and set its sessionId property to
			// sessionId
			SessionHeader sessionHeader = new SessionHeader();
			sessionHeader.setSessionId(loginResult.getSessionId());
			// To get a service locator object for custom web service
			JavaToSalesforceWebServiceExampleServiceLocator locator = new JavaToSalesforceWebServiceExampleServiceLocator();
			// To get URL for custom web service
			URL url = new URL(
					locator.getJavaToSalesforceWebServiceExampleAddress());
			// To create a stub for custom web service with URL for
			// service and locator as parameters
			JavaToSalesforceWebServiceExampleBindingStub stub = new JavaToSalesforceWebServiceExampleBindingStub(
					url, locator);
			stub.setHeader(
					locator.getJavaToSalesforceWebServiceExampleAddress(),
					"SessionHeader", sessionHeader);
			Scanner scanner = new Scanner(System.in);
			System.out.println("Enter SOQL here : ");
			String query = scanner.nextLine();
			if (query == null || query.isEmpty()) {
				System.out
						.println("query not entered \n Executing default query to retrieve contacts");
				query = "Select Name from Contact";
			}
			// Calling Apex class method to retrieve results of soql
			String soqlResponse = stub.retrieveQueryResults(query);
			System.out.println("Query result : \n\t" + soqlResponse);
			System.out
					.println("\n\n\n--------------------------------Insert New Student--------------------------------");
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
			// Calling apex class method to insert new student
			String newStudent = stub
					.insertStudent(firstName, lastName, classId);
			System.out
					.println("Student successfully inserted with following details : \n\t"
							+ newStudent);
			scanner.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
package WebService;

import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 * @author Nidhi Sharma Date : 18 feb,2016 Description : This class is to make
 *         connection to salesforce with provided login credentials
 *
 */
public class OAuthServlet {
	// To provide session
	public static JSONObject oAuthSessionProvider(String loginHost,
			String username, String password, String clientId, String secret)
			throws HttpException, IOException, JSONException {
		String tokenUrl = loginHost + "/services/oauth2/token";
		HttpClient httpclient = new HttpClient();
		PostMethod post = new PostMethod(tokenUrl);
		post.addParameter("grant_type", "password");
		post.addParameter("client_id", clientId);
		post.addParameter("client_secret", secret);
		post.addParameter("username", username);
		post.addParameter("password", password);
		try {
			httpclient.executeMethod(post);
			try {
				JSONObject authResponse = new JSONObject(new JSONTokener(
						new InputStreamReader(post.getResponseBodyAsStream())));
				return authResponse;
			} catch (JSONException e) {
				e.printStackTrace();
			}
		} catch (HttpException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		} finally {
			post.releaseConnection();
		}
		return null;
	}
}
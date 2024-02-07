import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../firebase/firebase_access_token.dart';


Future<String> getFirebaseAccessToken() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  DateTime expiryTime = DateTime.fromMillisecondsSinceEpoch(prefs.getInt('accessTokenExpiry') ?? 0);
  if (expiryTime.isBefore(DateTime.now())) {
    // Access token is expired, refresh it
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await AccessToken().refreshAccessToken(user);
      expiryTime = DateTime.fromMillisecondsSinceEpoch(prefs.getInt('accessTokenExpiry') ?? 0);
      print('new refresh token stored');
    }
  }
  return prefs.getString('firebaseAccessToken') ?? '';
}

class ApiService {
  Future<http.Response> postUserData(String phoneNumber) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl);
      var headers = {
        'Content-Type': ApiConstants.contentType,
        'Hasura-Client-Name': ApiConstants.hasuraConsoleClientName,
        'x-hasura-admin-secret': ApiConstants.adminSecret,
      };
      var body = json.encode({
        "mobileNumber": phoneNumber,
      });

      var response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow; // Rethrow the error to handle it in the calling function
    }
  }
  Future<http.Response> postBearerToken() async {
    try {
      String accessToken = await getFirebaseAccessToken();
      var url = Uri.parse(ApiConstants.baseUrl);
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };
      var body = '''''';

      var response = await http.post(url, headers: headers, body: body);
      return response;
    } catch (e) {
      log(e.toString());
      rethrow; // Rethrow the error to handle it in the calling function
    }
  }
}
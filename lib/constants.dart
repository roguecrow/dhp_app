import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'environment setup/flavour_settings.dart';

class ApiConstants {
  static late String baseUrl;

  static Future<void> initializeBaseUrl() async {
    baseUrl = FlavorSettings().apiBaseUrl;
    print('API URL $baseUrl');
  }



  static String sampleUrl = 'https://jsonplaceholder.typicode.com/users';


  static const String contentType = 'application/json';
  static const String hasuraConsoleClientName = 'hasura-console';
  static const String adminSecret = 'myadminsecret';
}




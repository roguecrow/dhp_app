
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'environment setup/environment.dart';
import 'environment setup/flavour_settings.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  FlavorSettings().initializeApiBaseUrl('https://jsonplaceholder.typicode.com/users');
  print('API URL ${FlavorSettings().apiBaseUrl}');
  WidgetsFlutterBinding.ensureInitialized();
  await ApiConstants.initializeBaseUrl();
  await Firebase.initializeApp(
      name: 'dhp',
      options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp(environment: EnvironmentValue.development,));
}

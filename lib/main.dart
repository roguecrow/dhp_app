import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'environment setup/environment.dart';
import 'environment setup/flavour_settings.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> main() async {
  FlavorSettings().initializeApiBaseUrl('https://prayojana-api-v1.slashdr-prod.com');
  print('API URL ${FlavorSettings().apiBaseUrl}');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'dhp',
      options: DefaultFirebaseOptions.currentPlatform);

  runApp( MyApp(environment: EnvironmentValue.production,));
}

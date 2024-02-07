
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:dhp_app/Theme/theme.dart';
import 'package:dhp_app/models/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/Login/auth_page.dart';
import 'environment setup/environment.dart';


final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {

  final Environment environment;

  const MyApp({super.key, required this.environment});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640), // Design size for your UI
      minTextAdapt: true,
      builder: (BuildContext context, Widget? widget) {
        return ConnectivityAppWrapper(
          app: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DHP',
            theme: lightMode,
            darkTheme: darkMode,
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00b466)),
            //   textTheme: GoogleFonts.poppinsTextTheme(
            //     Theme.of(context).textTheme,
            //   ),
            // ),
            home: const RegisterScreen(),
                  //const BottomNavigator(),
            builder: (buildContext, widget) {
              return ConnectivityWidgetWrapper(
                disableInteraction: true,
                //offlineWidget: const OfflineWidget(),
                height: 50.h,
                child: widget!,
              );
            },
            routes: {
              '/register': (context) => const RegisterScreen(),
              // Other named routes...
            },
          ),
        );
      },
    );
  }
}
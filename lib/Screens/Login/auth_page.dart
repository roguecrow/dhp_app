// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:dhp_app/Screens/DashBoard/dashboard_view.dart';
import 'package:dhp_app/Theme/theme.dart';
import 'package:dhp_app/models/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../firebase/firebase_access_token.dart';
import '../../models/navigation_bar.dart';
import '../../services/api_service.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phoneController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;

  String otpPin = "";
  String countryDial = "+1";
  String verID = "";
  bool isVerifyingOTP = false;

  int screenState = 0;
  bool isOtpButtonDisabled = false;

  bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> verifyPhone(String number) async {

    print('number : $number');
    print('in verifyPhone - $screenState');
    setState(() {
      isOtpButtonDisabled = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 10),
      verificationCompleted: (PhoneAuthCredential credential) {
        showSnackBarText("Auth Completed!");
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Verification Failed'),
              content: Text(
                e.message ?? 'Unknown error occurred', // Display Firebase error message
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        showCustomTopSnackbar(context, 'OTP Sent!');
        verID = verificationId;
        setState(() {
          screenState = 1;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    ).whenComplete(() {
      print('verifyPhoneNumber called');
      print('otp sent');
      if (mounted) {
        setState(() {
          isOtpButtonDisabled = false;
        });
      }
    });
  }


  Future<void> verifyOTP() async {
    print(screenState);
    setState(() {
      isVerifyingOTP = true;
    });

    try {
      final authResult = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verID,
          smsCode: otpPin,
        ),
      );

      await AccessToken().getFirebaseAccessToken(authResult.user);
      final apiService = ApiService();
      var response = await apiService.postBearerToken();
      print('checkUser response body - ${response.body}');

      if (response.statusCode > 200 || response.statusCode < 300 ) {
        // Store response body and user_id in local storage
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('loginUserDetails', response.body);
        // await prefs.setInt('userId', json.decode(response.body)['user_id']);
        // await prefs.setInt('roleId', json.decode(response.body)['role_id']);
        //initiates fire firebase messaging api
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNavigator(),
          ),
        );
      } else {
        print(response.body);
        print(response.statusCode);
        //showSnackBarText("User does not exist.");
        showCustomTopSnackbar(context, "User does not exist.");
      }
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        showCustomTopSnackbar(context, "Invalid OTP. Please try again.");
      } else {
        print('Error: $e');
        //showSnackBarText("An error occurred. Please try again later.");
        String errorMessage = e.toString();
        showCustomTopSnackbar(context, errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          isVerifyingOTP = false;
        });
      }
    }
  }



  Future<void> registerUserAndVerifyPhone() async {
    try {
      final apiService = ApiService();
      var response = await apiService.postUserData(countryDial + phoneController.text);
      if (response.statusCode > 200 || response.statusCode < 300 ) {
        //showSnackBarText("API call success, now verify phone number!");
        verifyPhone(countryDial + phoneController.text);
      } else {
        print(response.statusCode);
        print(response.body);
        //showSnackBarText("Mobile number not registered");
        showCustomTopSnackbar(context, 'Mobile number not registered');
      }
    } catch (e) {
      //showSnackBarText("Error occurred, try again later.");
      String errorMessage = e.toString();
      showCustomTopSnackbar(context, errorMessage);
     // showCustomTopSnackbar(context, "Error occurred, try again later.");

    } finally {
      if (mounted) {
        setState(() {
          isOtpButtonDisabled = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenUtil().screenHeight;
    double screenWidth = ScreenUtil().screenWidth;

    return PopScope(
      canPop:true,
      onPopInvoked: (bool didPop) async{
        //  onWillPop: () async {
        setState(() {
          screenState = 0;
        });
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor:  Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children:[
            Positioned(
              top: 50.h,
              left: 30.w,
              child: Image.asset(
                'assets/UHI_Logo.png',
                fit: BoxFit.cover,
                color: Colors.white,
              ),
            ),
            Center(
            child: SizedBox(
              height: screenHeight / 2.5,
              width: screenWidth / 1.1,
              child: Container(
                decoration: BoxDecoration(
                  color:  isDarkMode(context)
                      ? Colors.black
                      : Colors.white,// Change to the desired color
                  borderRadius: BorderRadius.circular(20.0.r), // Set the border radius
                ),
                child: Stack(
                 // alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sign in to your account",
                              style: GoogleFonts.inter(
                                textStyle: Theme.of(context).textTheme.displayLarge,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.left,
                            ),

                            screenState == 0 ? stateRegister() : stateOTP(),
                            GestureDetector(
                              onTap: isVerifyingOTP
                                  ? null
                                  : () {
                                if (screenState == 0) {
                                  if (phoneController.text.isEmpty) {
                                    //showSnackBarText("Phone number is still empty!");
                                    showCustomTopSnackbar(context, "Phone number is still empty!");
                                  } else {
                                    if (countryDial == "+1") {
                                      // showSnackBarText("Please select a country code.");
                                      showCustomTopSnackbar(context, "Please select a country code.");

                                      return;
                                    } else {
                                      registerUserAndVerifyPhone();
                                    }
                                  }
                                } else {
                                  if (otpPin.length >= 6) {
                                    verifyOTP();
                                  } else {
                                    //showSnackBarText("Enter OTP correctly!");
                                    showCustomTopSnackbar(context, "Enter OTP correctly!");
                                  }
                                }
                              },
                              child: SizedBox(
                                width: 300.w, // <-- Your width
                                height: 40.h, // <-- Your height
                                child: FilledButton(
                                  onPressed: isVerifyingOTP
                                      ? null
                                      : () async {
                                    if (screenState == 0) {

                                      setState(() {
                                        isVerifyingOTP = true; // Show loader immediately
                                      });
                                      await Future.delayed(const Duration(seconds: 5)); // Delay for 5 seconds
                                      setState(() {
                                        isVerifyingOTP = false; // Hide loader after 5 seconds
                                      });
                                      if (phoneController.text.isEmpty) {
                                        //showSnackBarText("Phone number is still empty!");
                                        showCustomTopSnackbar(context, "Phone number is still empty!");
                                      } else {
                                        if (countryDial == "+1") {
                                          //showSnackBarText("Please select a country code.");
                                          showCustomTopSnackbar(context, "Please select a country code.");
                                          return;
                                        } else {
                                          registerUserAndVerifyPhone();
                                        }
                                      }
                                    } else {
                                      if (otpPin.length >= 6) {
                                        print('verifyOTP called');
                                        print('otpPin length: ${otpPin.length}');
                                        verifyOTP();
                                      } else {
                                        // showSnackBarText("Enter OTP correctly!");
                                        showCustomTopSnackbar(context, "Enter OTP correctly!");
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                      const Color(0xff00b466), // Change this color to your desired button color
                                    ),
                                  ),
                                  child: isVerifyingOTP
                                      ? const LoadingIndicator(
                                    colors: [Colors.white],
                                    indicatorType: Indicator.ballPulse,/// Required, The loading type of the widget
                                    //strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                                    //backgroundColor: Colors.white,      /// Optional, Background of the widget
                                    //pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
                                  )
                                      : Text(
                                    screenState == 0 ? "Get OTP" : "Verify Account",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ]
        ),
      ),
    );
  }

  void showSnackBarText(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }
  }

  Widget stateRegister() {
    countryDial = "+91";

    return Padding(
      padding:  EdgeInsets.only(left: 15.0.w, right:  15.0.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone number",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8.h),
          IntlPhoneField(
            controller: phoneController,
            showCountryFlag: false,
            showDropdownIcon: true,
            initialCountryCode: "IN",
            onChanged: (phone) {
              setState(() {
                countryDial = "+${phone.countryCode}";
              });
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6b7280)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff6b7280)),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal:  ScreenUtil().setWidth(16),
                vertical: 14.h,
              ),
              counterText: "",
              hintText: "+1 (555) 987-6543",
            ),
          ),
        ],
      ),
    );
  }

  Widget stateOTP() {
    return Padding(
      padding:  EdgeInsets.only(left: 15.0.w, right:  15.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "OTP",
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 20.h / 14.h,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8.h,),
          Stack(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    otpPin = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'enter OTP',
                  hintText: '******',
                  border: OutlineInputBorder(),
                ),
              ),
              Positioned(
                right: ScreenUtil().setWidth(16), // Use ScreenUtil().setWidth() for the right position
                top: ScreenUtil().setHeight(14), // Use ScreenUtil().setHeight() for the top position
                child: TweenAnimationBuilder<Duration>(
                  duration: const Duration(minutes: 1),
                  tween: Tween(begin: const Duration(minutes: 1), end: Duration.zero),
                  onEnd: () {
                    print('Timer ended');
                  },
                  builder: (BuildContext context, Duration value, Widget? child) {
                    final minutes = value.inMinutes;
                    final seconds = value.inSeconds % 60;
                    return Text(
                      '$minutes:$seconds',
                      textAlign: TextAlign.center,
                      style:TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        screenState = 0;
                      });
                    },
                    child: Text(
                      "Change Phone number",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        //height: 3.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomTopSnackbar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16.0.h, // Adjust the top padding as needed
      left: 16.0.w,
      right: 16.0.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 6.0.h),
          decoration: BoxDecoration(
            color: message == 'Invalid OTP. Please try again.' ?  Colors.red : Colors.black45 ,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0.sp,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
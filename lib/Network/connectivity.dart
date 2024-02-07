import 'package:flutter/material.dart';

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Customize the background color for the offline widget
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_off, // Icon to indicate offline status
              size: 50,
              color: Colors.white, // Customize the icon color
            ),
            SizedBox(height: 20),
            Text(
              'No Internet Connection', // Offline message
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // Customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

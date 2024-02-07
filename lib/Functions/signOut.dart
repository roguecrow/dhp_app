import 'package:dhp_app/Screens/Login/auth_page.dart';
import 'package:flutter/material.dart';

void showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register', // Replace this with your route name
                    (Route<dynamic> route) => false, // Remove all routes from the stack
              );
            },
          ),
        ],
      );
    },
  );
}
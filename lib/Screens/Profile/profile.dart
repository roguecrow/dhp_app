import 'package:dhp_app/models/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor:  Theme.of(context).primaryColor,
      ),
      body: const Center(child: Text('Profile of DHP')),
    );
  }
}

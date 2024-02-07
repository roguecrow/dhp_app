import 'package:flutter/material.dart';

import '../../models/custom_appbar.dart';

class DoctorsView extends StatefulWidget {
  const DoctorsView({super.key});

  @override
  State<DoctorsView> createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: 'Doctors',
        searchVisibility: true, // Set the title
      ),
      body: const Center(
        child: Text('HELLO DHP\'s'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );  }
}

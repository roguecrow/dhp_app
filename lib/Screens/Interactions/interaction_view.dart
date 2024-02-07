import 'package:flutter/material.dart';

import '../../models/custom_appbar.dart';

class InteractionView extends StatefulWidget {
  const InteractionView({super.key});

  @override
  State<InteractionView> createState() => _InteractionViewState();
}

class _InteractionViewState extends State<InteractionView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: 'Interactions',
        searchVisibility: true, // Set the title
      ),
      body: const Center(
        child: Text('HELLO DHP\'s'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

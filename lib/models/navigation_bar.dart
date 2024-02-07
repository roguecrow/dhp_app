import 'package:dhp_app/Screens/Calendar/calendar_view.dart';
import 'package:dhp_app/Screens/DashBoard/dashboard_view.dart';
import 'package:dhp_app/Screens/Doctors/doctors_view.dart';
import 'package:dhp_app/Screens/Interactions/interaction_view.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  final List<Widget> _pages = [
     const DashBoard(),
     const DoctorsView(),
     const InteractionView(),
     const Calendar(),
  ];

  @override
  void initState() {
    super.initState();
    print('initiated notification');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Use the current page based on _currentIndex
      bottomNavigationBar: NavigationBar(
        //backgroundColor: Color(0xff00b466),
        labelBehavior: labelBehavior,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'DashBoard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt),
            label: 'Doctors',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.view_list_rounded),
            label: 'Interactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:overcomers_place/screens/newfeed.dart';
import 'package:overcomers_place/screens/calendar.dart';
import 'package:overcomers_place/screens/support.dart';
import 'package:overcomers_place/constants.dart';

import 'constants.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overcomers Place',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TopApplication(),
    );
  }
}

class TopApplication extends StatefulWidget {
  @override
  _TopApplicationState createState() => _TopApplicationState();
}

class _TopApplicationState extends State<TopApplication> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    NewsScreen(),
    CalendarScreen(),
    SupportScreen()
  ];

  List<Widget> _appBars = [
    kNewsBar,
    kCalendarBar,
    kSupportBar
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBaseColor,
        selectedItemColor: kSelectedColors,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            title: Text('Support'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },

      ),
//      appBar: _appBars[_selectedIndex],
      body: SafeArea(child: _screens[_selectedIndex]),


    );
  }
}




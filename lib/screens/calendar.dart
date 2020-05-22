import 'package:flutter/material.dart';
import 'package:overcomers_place/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Upcoming Events'),
          backgroundColor: kSecondColor,
        ),
        TableCalendar(
          calendarController: _calendarController,
        )
      ],
    );
  }
}

class CalendarAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Upcoming Events'),
    );
  }
}

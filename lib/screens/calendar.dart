import 'package:flutter/material.dart';
import 'package:overcomers_place/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:overcomers_place/api_helper.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  Map<DateTime, List> _holidays;
  List _selectedEvents;
  var _calData;

  Future<dynamic> getCalendarData() async {
    NetworkHelper netHelper = NetworkHelper('http://localhost:3000');
    var calendarData = await netHelper.getShortEvents();
    return calendarData;
  }


  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
    };

    _holidays = {
      DateTime(2019, 1, 1): ['New Year\'s Day'],
      DateTime(2019, 1, 6): ['Epiphany'],
      DateTime(2019, 2, 14): ['Valentine\'s Day'],
      DateTime(2019, 4, 21): ['Easter Sunday'],
      DateTime(2020, 6, 22): ['Easter Monday'],
    };

    _calendarController = CalendarController();
    _calData = getCalendarData();
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
          centerTitle: true,
        ),
        TableCalendar(
          calendarController: _calendarController,
          events: _events,
          holidays: _holidays,
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

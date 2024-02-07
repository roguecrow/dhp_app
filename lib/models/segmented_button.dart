
import 'package:flutter/material.dart';

enum Calendar { day, week, month, year }

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      showSelectedIcon: false,
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('WTD'),
            //icon: Icon(Icons.calendar_view_day)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('MTD'),
           // icon: Icon(Icons.calendar_view_week)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('YTD'),
           // icon: Icon(Icons.calendar_view_month)
        ),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text('ALL'),
            //icon: Icon(Icons.calendar_today)
        ),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}
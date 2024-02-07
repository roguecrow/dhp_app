import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Functions/calender_date.dart';
import '../../models/custom_appbar.dart';
class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime today = DateTime.now();
  Map<String, dynamic>? calendarDetail; // Add this line
  bool showCalendar = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: 'Calendar',
        searchVisibility: false, // Set the title
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(18.0.dm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewDate(today),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkResponse(
                      onTap: () {
                        toggleCalendar();
                      },
                      child: Icon(Icons.calendar_month,
                        color: showCalendar ?  const Color(0xff00b466) : null,
                      ),
                    )
                  ],
                ),
              ),

              if (showCalendar)
                Container(
                  //margin: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 20.h),
                  child:
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2030),
                    currentDate: today,
                    onDateChanged: (DateTime value) {
                      setState(() {
                        today = value; // Use 'today' if 'day' is null
                      });
                    },
                  ),

                  // TableCalendar(
                  //   headerStyle: const HeaderStyle(formatButtonVisible: false,titleCentered: true),
                  //   availableGestures: AvailableGestures.all,
                  //   firstDay: DateTime.utc(1900, 1, 1),
                  //   lastDay: DateTime.utc(3000, 12, 31),
                  //   focusedDay: today,
                  //   onDaySelected: _onDaySelected,
                  //   selectedDayPredicate: (day) => isSameDay(day, today),
                  //   calendarStyle:  CalendarStyle(
                  //     todayDecoration: BoxDecoration(
                  //       //color: Colors.lightGreen, // Change to the desired color
                  //       shape: BoxShape.circle, // You can customize the shape as well
                  //       border: Border.all(
                  //         color: Colors.lightGreen, // Change to the desired border color
                  //         width: 2.0, // Change to the desired border width
                  //       ),
                  //     ),
                  //     selectedDecoration: const BoxDecoration(
                  //       color: Colors.lightGreen, // Change to the desired color
                  //       shape: BoxShape.circle, // You can customize the shape as well
                  //     ),
                  //   ),
                  //   // onDaySelected: _onDaySelected, // Call the function when a day is selected
                  //   // ... Customize the calendar as needed ...
                  // ),
                ),
            ],
          ),
        )
    );
  }

  void toggleCalendar() {
    setState(() {
      showCalendar = !showCalendar;
    });
  }

  void _onDaySelected(DateTime day, DateTime focusedDay)  {
    setState(()  {
      today = day; // Use 'today' if 'day' is null
    });
  }

}

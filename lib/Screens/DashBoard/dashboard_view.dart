import 'package:dhp_app/models/segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/custom_appbar.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: 'DashBoard',
        searchVisibility: false, // Set the title
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16.0.w , top: 10.h , bottom: 15.h),
            child: const Align(
              alignment: Alignment.topRight,
              child: CustomSegmentedButton(),
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceVariant,
            child:  SizedBox(
              height: ScreenUtil().screenHeight / 10,
              width: ScreenUtil().screenWidth / 1.1,
              child: const Center(child: Text('revenue - 3000rs  -  doctors - 10')),
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(12.2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius:  BorderRadius.all(Radius.circular(12.r)),
                    ),
                    child:  SizedBox(
                      height: ScreenUtil().screenHeight / 7,
                      child: const Center(child: Text('Today Visits')),
                    ),
                  ),
                ),
                SizedBox(width: 10.w), // Adjust the spacing between the containers
                Expanded(
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius:  BorderRadius.all(Radius.circular(12.r)),
                    ),
                    child:  SizedBox(
                      height: ScreenUtil().screenHeight / 7,
                      child: const Center(child: Text('Task')),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 5.h, indent: 18.w, endIndent: 18.w),
          SizedBox(height :5.h),
          Center(child: Text('On Boarding List',style: TextStyle(fontSize: 20.sp))),
        ],
      ),
    );
  }
}

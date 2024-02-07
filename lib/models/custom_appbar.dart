

import 'package:dhp_app/models/search_anchor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Functions/signOut.dart';
import '../Screens/Profile/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool searchVisibility;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.searchVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    if (searchVisibility) {
      actions.add(
        const AsyncSearchAnchor(),
      );
    }

    actions.add(
      PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
             PopupMenuItem(
              child: Text('References',style: TextStyle(fontSize: 14.sp),),
            ),
             PopupMenuItem(
              child: Padding(
                padding: EdgeInsets.only(right: 70.0.w),
                child: Text('Offers',style: TextStyle(fontSize: 14.sp)),
              ),
               onTap: (){},
            ),
             PopupMenuItem(
              child: Text('Feedbacks',style: TextStyle(fontSize: 14.sp)),
               onTap: (){},
             ),
             PopupMenuItem(
              child: Text('Profile',style: TextStyle(fontSize: 14.sp)),
               onTap: () {
                 //_navigateToProfileScreen();
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context) => const ProfileScreen(),
                 ),);
               },
            ),
             PopupMenuItem(
              child: Text('Log out',style: TextStyle(fontSize: 14.sp)),
               onTap: () {
                 showSignOutDialog(context);
               },
            ),
          ];
        },
      ),
    );

    return AppBar(
      title: Text(title),
      backgroundColor:  Theme.of(context).primaryColor,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}




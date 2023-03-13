import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/font.dart';

import '../../../../core/colors.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../bloc/layout_cubit.dart';
import 'home_view.dart';
import 'profile_view.dart';
import 'service_view.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({Key? key}) : super(key: key);
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ServiceScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final LayoutCubit layoutCubit = LayoutCubit.get(context);
    final AuthCubit authCubit = AuthCubit.get(context);
    authCubit.getUserInfo();
    return  BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if(state is ChangeCurrentPageState){
          _selectedIndex=state.index;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 50.r,
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled,size: 16.r,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_new_sharp,size: 16.r,),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 16.r,),
                label: 'Me',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: defaultColor,
            unselectedItemColor: ceil,
            selectedLabelStyle: cairo(14.sp, defaultColor, FontWeight.w600),
            unselectedLabelStyle: openSans(14.sp, ceil, FontWeight.w600),
            onTap: (index) => layoutCubit.changeCurrentPage(index),
          ),
        );
      },
    );
  }
}

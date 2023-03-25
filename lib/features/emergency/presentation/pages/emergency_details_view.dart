
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/font.dart';
import '../../domain/entities/emergency.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  final Emergency emergency;
  final int number;
  const EmergencyDetailsScreen({Key? key, required this.emergency, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brightGray,
      appBar:
      defaultAppBar(title: 'Person$number details', context: context, withBack: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24.h,),
            Text('Name',style: openSans(16.sp, defaultColor, FontWeight.bold),textScaleFactor: 1,),
            SizedBox(height: 16.h,),
            Text(emergency.name,style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,),
            SizedBox(height: 24.h,),
            Text('Phone',style: openSans(16.sp, defaultColor, FontWeight.bold),textScaleFactor: 1,),
            SizedBox(height: 16.h,),
            Text(emergency.phone,style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,),

          ],
        ),
      ),
    );
  }
}

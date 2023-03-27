
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/font.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../domain/entities/first_aid.dart';
class FirstAidDetailsScreen extends StatelessWidget {
  final FirstAid firstAid;
  const FirstAidDetailsScreen({Key? key, required this.firstAid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lotion,
      appBar:
      defaultAppBar(title: firstAid.title, context: context, withBack: true),
body: Container(
  margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(4.r,),
    boxShadow: [
      BoxShadow(
          color: brightGray,
          blurRadius: 6,
          offset: const Offset(0, 3)
      )
    ],
  ),
  child: SingleChildScrollView(child: Text(firstAid.body,style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,)),

),
    );
  }
}

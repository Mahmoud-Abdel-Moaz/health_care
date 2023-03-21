import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';

import '../../../../core/colors.dart';
import '../../../../core/font.dart';
import '../../domain/entities/place.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;
  final String type;

  const PlaceDetails({Key? key, required this.place, required this.type})
      : super(key: key);

//AIzaSyCU97vb0CVV97TtavlB8k6JPon4ryqw3N0
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lotion,
      appBar:
          defaultAppBar(title: place.name, context: context, withBack: true),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: ImageIcon(
              AssetImage('assets/images/$type.png'),
              color: defaultColor,
              size: 70.r,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          itemDesign('Name',place.name),
          SizedBox(height: 8.h,),
          itemDesign('Availability',place.availability),
          SizedBox(height: 8.h,),
          itemDesign('Address',place.address),
          SizedBox(height: 8.h,),
          itemDesign('Number',place.number),
        ],
      ),
    );
  }

  Container itemDesign(String title,String value) {
    return Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              4.r,
            ),
            boxShadow: [
              BoxShadow(
                  color: brightGray,
                  blurRadius: 6,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                style: openSans(16.sp, defaultColor, FontWeight.w600),
                textScaleFactor: 1,
              ),Text(
                value,
                style: openSans(16.sp, Colors.black, FontWeight.w400),
                textScaleFactor: 1,
              ),
            ],
          ),
        );
  }
}

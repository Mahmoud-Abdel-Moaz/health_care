
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/hospitals/presentation/pages/place_details_view.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/place.dart';

class HospitalItemView extends StatelessWidget {
  final Place place;
  final String type;
  const HospitalItemView({Key? key, required this.place, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(place.name,style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,),
          SizedBox(height: 8.h,),
          Text(place.availability,style: openSans(14.sp, green, FontWeight.w400),textScaleFactor: 1,),
          SizedBox(height: 8.h,),
Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    const Flexible(fit:FlexFit.tight,child: SizedBox()),
        defaultButton(onTap: ()=>navigateTo(context, PlaceDetails(place: place, type: type)), text: 'Get Details'),
    const Flexible(fit:FlexFit.tight,child: SizedBox()),

  ],
),
        ],
      ),
    );
  }
}

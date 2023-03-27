
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/hospitals/presentation/pages/place_details_view.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/first_aid.dart';
import '../pages/first_aid_details_view.dart';

class FirstAidItemView extends StatelessWidget {
final FirstAid firstAid;

  const FirstAidItemView({super.key, required this.firstAid});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 36.w,vertical: 24.h),
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
      child: Center(child:  defaultButton(onTap: ()=>navigateTo(context, FirstAidDetailsScreen(firstAid: firstAid,)), text: firstAid.title),),
    );
  }
}

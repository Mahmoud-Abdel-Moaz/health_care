
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/constants.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/emergency/presentation/pages/emergency_details_view.dart';

import '../../domain/entities/emergency.dart';

class EmergencyItemView extends StatelessWidget {
  final Emergency emergency;
  final int number;
  const EmergencyItemView({Key? key, required this.emergency, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Person $number',style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,),
        SizedBox(height: 8.h,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: defaultButton(onTap: ()=>navigateTo(context, EmergencyDetailsScreen(emergency: emergency, number: number)), text: 'Details')),
            SizedBox(width: 8.w,),
            Flexible(child: defaultButton(onTap: ()=>makeCall(emergency.phone), text: 'Call',background: Colors.redAccent)),

          ],
        )
      ],
    );
  }
}

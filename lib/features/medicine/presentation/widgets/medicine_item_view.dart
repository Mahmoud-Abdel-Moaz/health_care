
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/font.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/medicine.dart';

class MedicineItemView extends StatelessWidget {
  final Medicine medicine;
  const MedicineItemView({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: brightGray,
            blurRadius: 6,
            offset: const Offset(0, 3)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(AssetImage('assets/images/medicine/${medicine.shape}.png'),color: defaultColor,size: 60.r,),
SizedBox(height: 16.h,),
          Text(medicine.name,style: openSans(16.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,),
          SizedBox(height: 16.h,),
          Text(medicine.dose,style: openSans(12.sp, defaultColor, FontWeight.w300),textScaleFactor: 1,),

        ],
      ),
    );
  }
}

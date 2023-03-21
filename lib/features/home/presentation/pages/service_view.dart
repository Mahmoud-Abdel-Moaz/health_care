import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/colors.dart';
import 'package:health_care/core/constants.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/home/presentation/pages/app_service.dart';
import 'package:health_care/features/hospitals/presentation/pages/places_view.dart';

import '../../../../core/compnents.dart';
import '../../../medicine/presentation/pages/medicine_view.dart';

class ServiceScreen extends StatelessWidget {
  ServiceScreen({Key? key}) : super(key: key);


  serviceItem(AppService appService)=>Flexible(fit:FlexFit.tight,child: GestureDetector(
    onTap: appService.onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        border: Border.all(color: defaultColor,width: 1.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(AssetImage(appService.image),color: defaultColor,size: 60.r,),
          SizedBox(height: 8.h,),
          Text(appService.title,style: openSans(16.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,),
        ],
      ),
    ),
  ),);


  @override
  Widget build(BuildContext context) {
    final services = [
      AppService(
        'assets/images/hospital.png',
        'Hospital',
            () =>navigateTo(context,const PlacesTypeScreen(type: 'hospital', title: 'Hospitals')),
      ),    AppService(
        'assets/images/lab.png',
        'Laboratory',
            () {},
      ),
      AppService(
        'assets/images/first_aid.png',
        'First Aid',
            () {},
      ),
      AppService(
        'assets/images/pharmacy.png',
        'Pharmacy',
            () {},
      ),
      AppService(
        'assets/images/emergency.png',
        'Emergency',
            () {},
      ),
      AppService(
        'assets/images/medicine.png',
        'Medicine Remindar',
            ()=>navigateTo(context, const MedicineScreen()),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 8.w),
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  serviceItem(services[0]),
                  SizedBox(width: 16.w,),
                  serviceItem(services[1]),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  serviceItem(services[2]),
                  SizedBox(width: 16.w,),
                  serviceItem(services[3]),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  serviceItem(services[4]),
                  SizedBox(width: 16.w,),
                  serviceItem(services[5]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/colors.dart';
import 'package:health_care/core/constants.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/core/local_notification_service.dart';
import 'package:health_care/features/auth/presentation/pages/login_view.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/compnents.dart';
import '../../../auth/domain/entities/user_info.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit=AuthCubit.get(context);
    authCubit.getUserInfo();
    FullUserInfo? userInfo = authCubit.userInfo;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state is LoadedGetUserInfoState){
              userInfo=state.userInfo;
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: userInfo!=null,
              fallback: (context)=> Center(child: CircularProgressIndicator(color: defaultColor,),),
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle, size: 64.r,),
                        SizedBox(height: 16.sp,),
                        Text(userInfo?.name??'',style: openSans(14.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,textAlign: TextAlign.center,),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 70.r+16.h+16.h+4.h+12.sp,
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Contact Us',style: openSans(18.sp, Colors.white, FontWeight.bold),textScaleFactor: 1,textAlign: TextAlign.center,),
                              Text('health_care@gmail.com',style: openSans(14.sp, Colors.white, FontWeight.w600),textScaleFactor: 1,textAlign: TextAlign.center,),

                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 60.r,
                                height: 60.r,
                              ),
                              SizedBox(height: 4.h,),
                              Text('Health care',style: openSans(12.sp, Colors.black, FontWeight.w400),textScaleFactor: 1,textAlign: TextAlign.center,),
                            ],
                          ),
                        ],
                      ),
                    ),
GestureDetector(
  onTap: (){
    try{
      FirebaseAuth.instance.signOut();
      notificationId=1;
      CacheHelper.saveData(key: 'notification_id', value: notificationId);
      LocalNotificationService.cancelNotification();

    }catch(e){

    }
    userId=null;
    CacheHelper.removeData(key: 'user_id');
    navigateToAndFinish(context,const LoginScreen());
  },
  child:   Container(
    color: Colors.transparent,
    child:   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.logout,color: defaultColor,size: 16.r,),
        Text('Log out',style: openSans(14.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,textAlign: TextAlign.center,),

      ],
    ),
  ),
)
                  ],
                );
              }
            );
          },
        ),
      ),
    );
  }
}

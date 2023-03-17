import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/font.dart';

import '../../../../core/colors.dart';
import '../../../auth/domain/entities/user_info.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit.get(context);
    FullUserInfo? userInfo = authCubit.userInfo;
    FontWeight headerFontWeight = FontWeight.w600;
    FontWeight dataFontWeight = FontWeight.w400;
    double headerFontSize = 16.sp;
    double dataFontSize = 14.sp;
    Color headerColor = defaultColor;
    Color dataColor = Colors.black;
    double headerSpace = 16.h;
    double dataSpace = 8.h;

    authCubit.getUserInfo();
    return Scaffold(
      backgroundColor: brightGray,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoadedGetUserInfoState) {
            userInfo = state.userInfo;
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => ListView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    gradient: LinearGradient(colors: [
                      startProfileHeaderColor,
                      midProfileHeaderColor,
                      endProfileHeaderColor
                    ]),
                    border: Border.all(color: spanishGray, width: 1.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 64.r,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                          child: Text(
                        userInfo?.name ?? '',
                        style: openSans(16.sp, Colors.black, FontWeight.w600),
                        textScaleFactor: 1,
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    border: Border.all(color: spanishGray, width: 1.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: openSans(
                            headerFontSize, headerColor, headerFontWeight),
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        height: headerSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Gender:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.gender??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Blood type:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.bloodType??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Phone number:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.phoneNumber??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'National ID:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.nationalId??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Address:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.address??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Birthday Date:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.birthDate??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Divider(
                        color: spanishGray,
                        height: 1.h,
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Text(
                        'Health Information',
                        style: openSans(
                            headerFontSize, headerColor, headerFontWeight),
                        textScaleFactor: 1,
                      ),
                      SizedBox(
                        height: headerSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Infection state:',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.infectionState??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Taking vaccine',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.takingVaccine??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Vaccine type',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.vaccineType??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Vaccine dose',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.vaccineDose??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Vaccine date',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.vaccineDate??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: dataSpace,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Chronic disease',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                              child: Text(
                            userInfo?.chronicDisease??'',
                            style: openSans(
                                dataFontSize, dataColor, dataFontWeight),
                            textScaleFactor: 1,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            condition: userInfo != null,
          );
        },
      ),
    );
  }
}

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
            builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
                  )
                ],
              ),
            ),
            condition: userInfo != null,
          );
        },
      ),
    );
  }
}

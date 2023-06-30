import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';

import '../../../../core/colors.dart';
import '../../../../core/font.dart';
import '../../../home/presentation/pages/layout_view.dart';
import '../bloc/auth_cubit.dart';
import 'start_register_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final emailFocusNode = FocusNode();
    final passwordController = TextEditingController();
    final passwordFocusNode = FocusNode();
    bool passwordVisible = true;
    bool isLoading = false;
    AuthCubit authCubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ChangePasswordVisibilityState) {
              passwordVisible = state.visible;
            } else if (state is LoadingLoginState) {
              isLoading = true;
            } else if (state is LoadedLoginState) {
              isLoading = false;
              showToast(msg: 'Welcome', state: ToastStates.success);
              navigateToAndFinish(context, LayoutScreen());
            } else if (state is ErrorLoginState) {
              isLoading = false;
              showToast(msg: state.message, state: ToastStates.error);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 120.r,
                          height: 120.r,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          'Health care',
                          style: openSans(20.sp, Colors.black, FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                        SizedBox(
                          height: 150.h,
                        ),
                        customTextField(
                          controller: emailController,
                          context: context,
                          hint: 'E-mail',
                          label: 'E-mail',
                          type: TextInputType.emailAddress,
                          focusNode: emailFocusNode,
                          icon: Icons.email,
                          onSubmit: () => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        passwordTextField(
                          controller: passwordController,
                          context: context,
                          hint: 'Password',
                          label: 'Password',
                          focusNode: passwordFocusNode,
                          obscureText: passwordVisible,
                          onSubmit: () => FocusScope.of(context).unfocus(),
                          onTap: () => authCubit
                              .changePasswordVisibility(!passwordVisible),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                defaultButton(
                    onTap: () {
                      if (!isLoading) {
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          authCubit.login(
                              email: emailController.text,
                              password: passwordController.text);
                        } else {
                          showToast(
                              msg: 'Enter Full Info', state: ToastStates.error);
                        }
                      }
                    },
                    text: 'Login',
                    isLoading: isLoading),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: openSans(14.sp, Colors.black, FontWeight.w400),
                      textScaleFactor: 1,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    GestureDetector(
                        onTap: () =>
                            navigateTo(context, const StartRegisterScreen()),
                        child: Text(
                          "Register Now",
                          style: openSans(14.sp, secondColor, FontWeight.w400),
                          textScaleFactor: 1,
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

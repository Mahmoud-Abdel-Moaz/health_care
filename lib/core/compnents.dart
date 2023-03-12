import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';
import 'font.dart';

navigateTo(context, widget, {void Function()? than}) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
).then((value) => than);

Future<void> navigateToAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (Route<dynamic> route) {
      return false;
    });

void navigateToAndReplacement(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
  /*      (Route<dynamic> route){
      return false;
    }*/
);

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: _chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

Color _chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      return Colors.green;
    case ToastStates.warning:
      return Colors.yellow;
    case ToastStates.error:
      return Colors.red;
  }
}

enum ToastStates { success, error, warning }

AppBar defaultAppBar({
  required String title,
  bool centerTitle = true,
  required BuildContext context,
  List<Widget>? actions = const [],
  double? titleSize,
  double? elevation,
  Color? background,
  Color? titleColor,
  Color? iconColor,
  void Function()? onBack,
  bool withBack = false,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    actions: actions,
    title: Text(
      title,
      style: openSans(
          titleSize ?? 20.sp, titleColor ?? defaultColor, FontWeight.bold),
      textScaleFactor: 1,
    ),
    centerTitle: centerTitle,
    backgroundColor: background ?? const Color(0xff58595b),
    elevation: elevation,
    bottom: bottom,
    leading: withBack
        ? GestureDetector(
        onTap: onBack ??
                () {
              Navigator.of(context).pop();
            },
        child: Icon(
          Icons.arrow_back_ios_rounded,
          color: iconColor ?? defaultColor,
          size: 20.r,
        ))
        : null,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
        bottomRight: Radius.circular(20.r),
      ),
    ),
  );
}

customTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required String label,
  required FocusNode focusNode,
  required IconData icon,
  bool obscureText = false,
  bool enable=true,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: openSans(14.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,),
          SizedBox(height: 8.h,),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1.r, color: defaultColor),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,color: oldSilver,size: 20.r,),
                SizedBox(width: 8.w,),
                Expanded(
                  child: TextFormField(
                    style: openSans(14, Colors.black, FontWeight.w600),
                    decoration: InputDecoration(
                        isDense: true,
                        enabled: enable,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        disabledBorder: InputBorder.none,
                        hintText: hint,
                        hintStyle: openSans(14, oldSilver, FontWeight.w300)),
                    controller: controller,
                    keyboardType: type,
                    obscureText: obscureText,
                    onFieldSubmitted: (value) {
                      onSubmit();
                    },
                    focusNode: focusNode,
                    validator: validator,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

passwordTextField({
  required TextEditingController controller,
  required BuildContext context,
  required String hint,
  required String label,
  required FocusNode focusNode,
  required bool obscureText,
  double? height,
  double? verticalPadding,
  TextInputType type = TextInputType.text,
  required void Function() onSubmit,
  required void Function() onTap,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(focusNode);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: openSans(14.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,),
        SizedBox(height: 8.h,),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            //   color: defaultColor,
            border: Border.all(width: 1.r, color: defaultColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.lock_rounded,color: oldSilver,size: 14.sp,),
              SizedBox(width: 8.w,),
              Expanded(
                child: TextFormField(
                  style: openSans(14, Colors.black, FontWeight.w600),
                  decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      disabledBorder: InputBorder.none,
                      suffixIconConstraints:
                      BoxConstraints(minWidth: 14.r, maxHeight: 14.r),
                      suffixIcon: GestureDetector(
                        onTap: onTap,
                        child: SizedBox(
                          width: 14.r,
                          height: 14.r,
                          child: Icon(
                            !obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            // size: 20.w,
                            color: oldSilver,
                          ),
                        ),
                      ),
                      hintText: hint,
                      hintStyle: openSans(14, oldSilver, FontWeight.w300)),
                  controller: controller,
                  keyboardType: type,
                  obscureText: obscureText,
                  onFieldSubmitted: (value) {
                    onSubmit();
                  },
                  focusNode: focusNode,
                  validator: validator,
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget defaultButton(
    {required void Function() onTap,
      required String text,
      bool isLoading = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        vertical: 11.h,
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: defaultColor,
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
        )
            : Text(
          text,
          style: openSans(16.sp, Colors.white, FontWeight.bold),
          textScaleFactor: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}




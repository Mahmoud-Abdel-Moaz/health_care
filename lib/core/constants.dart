import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'colors.dart';
import 'font.dart';

const projectId='raya-68237';

//const baseUrl='http://souqcom.alahlih-antibugs.com/api/';
const internetError='تأكد من الأتصال بالأنترنت';
bool enableNotification=true;
bool enableRate=true;

setDefaultStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: defaultColor,
    statusBarBrightness: Brightness.dark, //ios bar icons
    statusBarIconBrightness: Brightness.light, //ios bar icons
  ));
}

setWhiteStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff58595b),
    statusBarBrightness: Brightness.light, //ios bar icons
    statusBarIconBrightness: Brightness.dark, //ios bar icons
  ));
}

String convertDate(DateTime dateTime){
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String formattedDate = formatter.format(dateTime);
  return formattedDate;
}

void navigateTo(context, widget,{void Function()? onBack }) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    ).then((value) {
  onBack;
});

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
    );


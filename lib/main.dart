import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/features/emergency/presentation/bloc/emergency_cubit.dart';
import 'package:health_care/features/first_aid/presentation/bloc/first_aid_cubit.dart';
import 'package:health_care/features/home/presentation/pages/layout_view.dart';

import 'core/cache_helper.dart';
import 'core/constants.dart';
import 'core/local_notification_service.dart';
import 'features/auth/presentation/bloc/auth_cubit.dart';
import 'features/auth/presentation/pages/login_view.dart';
import 'features/home/presentation/bloc/layout_cubit.dart';
import 'features/hospitals/presentation/bloc/place_cubit.dart';
import 'features/medicine/presentation/bloc/medicine_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  userId=CacheHelper.getData(key: 'user_id');
  notificationId=CacheHelper.getData(key: 'notification_id')??1;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);

    return  MultiBlocProvider(
      providers: [
       BlocProvider(create: (_) =>EmergencyCubit()),
       BlocProvider(create: (_) =>  PlaceCubit()),
       BlocProvider(create: (_) =>  AuthCubit()),
       BlocProvider(create: (_) =>  LayoutCubit()),
       BlocProvider(create: (_) =>  MedicineCubit()),
       BlocProvider(create: (_) =>  FirstAidCubit()),

      ],
      child: ScreenUtilInit(
          designSize:const  Size(375, 812),
          minTextAdapt: true,
          builder: ( context,child) => MaterialApp(
            title: 'Health care',
            debugShowCheckedModeBanner: false,
            home:userId!=null? LayoutScreen():const LoginScreen(),
          )
      ),
    );
  }
}
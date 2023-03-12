import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/constants.dart';
import '../../data/models/user_info_model.dart';
import '../../domain/entities/user_info.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  FullUserInfo? userInfo;

  changeSelectedDate(DateTime dateTime) {
    emit(ChangeSelectedDateState(dateTime));
  }

  changeSelectedGender(String gender) {
    emit(ChangeSelectedGenderState(gender));
  }

  changePasswordVisibility(bool visible) {
    emit(ChangePasswordVisibilityState(visible));
  }

  changeVaccineDate(DateTime vaccineDate) {
    emit(ChangeVaccineDateState(vaccineDate));
  }

  changeSelectedBloodType(String bloodType) {
    emit(ChangeSelectedBloodTypeState(bloodType));
  }

  changeRegisterPasswordVisibility(bool visible) {
    emit(ChangeRegisterPasswordVisibilityState(visible));
  }

  changeRegisterPasswordVerifyVisibility(bool visible) {
    emit(ChangeRegisterPasswordVerifyVisibilityState(visible));
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  createAccount({
    required name,
    required nationalId,
    required gender,
    required birthDate,
    required phoneNumber,
    required email,
    required address,
    required governorate,
    required city,
    required infectionState,
    required takingVaccine,
    required vaccineDate,
    required vaccineDose,
    required bloodType,
    required chronicDisease,
    required password,
  }) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user.user != null) {
        UserInfoModel userInfoModel = UserInfoModel(
            user.user!.uid,
            name,
            nationalId,
            gender,
            birthDate,
            phoneNumber,
            email,
            address,
            governorate,
            city,
            infectionState,
            takingVaccine,
            vaccineDate,
            vaccineDose,
            bloodType,
            chronicDisease);
        saveUserInfo(userInfoModel);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const ErrorCreateAccountState(
            'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(const ErrorCreateAccountState(
            'The account already exists for that email.'));
      } else {
        emit(ErrorCreateAccountState(e.message ?? 'error'));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error createAccount $e');
      }
      emit(const ErrorCreateAccountState('error'));
    }
  }

  saveUserInfo(UserInfoModel userInfoModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userInfoModel.id)
          .set(userInfoModel.toJson());
      userId = userInfoModel.id;
      userInfo=userInfoModel;
      CacheHelper.saveData(key: 'user_id', value: userId);
      emit(LoadedCreateAccountState());
    } on FirebaseException catch (e) {
      emit(ErrorCreateAccountState(e.message ?? 'error'));
    } catch (e) {
      if (kDebugMode) {
        print('Error saveUserInfo $e');
      }
      emit(const ErrorCreateAccountState('error'));
    }
  }

  login({required String email, required String password}) async {
    try {
      emit(LoadingLoginState());
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        CacheHelper.saveData(key: 'user_id', value: userCredential.user!.uid);
        emit(LoadedLoginState());
      }else{
        emit(const ErrorLoginState('error'));
      }
      } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const ErrorLoginState('No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(const ErrorLoginState('Wrong password provided for that user'));
      } else {
        emit(ErrorLoginState(e.message ?? 'error'));
      }
    } catch (e) {
      if (kDebugMode) {
        print('error login $e');
      }
      emit(const ErrorLoginState('error'));
    }
  }

  getUserInfo()async{
    try{
      emit(LoadingGetUserInfoState());
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (documentSnapshot.exists) {
        //final data = documentSnapshot.data()!;
        Map<String, dynamic> data = documentSnapshot.data as Map<String, dynamic>;
        userInfo =UserInfoModel.fromJson(data);
        emit(LoadedGetUserInfoState(userInfo!));
        // Do something with the data
      } else {
        print('Document does not exist');
      }
    }catch(e){
      if (kDebugMode) {
        print('error getUserInfo $e');
      }
      emit(const ErrorGetUserInfoState('error'));

    }
  }
}

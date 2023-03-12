import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  changeSelectedDate(DateTime dateTime) {
    emit(ChangeSelectedDateState(dateTime));
  }
  changeSelectedGender(String gender) {
    emit(ChangeSelectedGenderState(gender));
  }

  changePasswordVisibility(bool visible){
    emit(ChangePasswordVisibilityState(visible));
  }


  changeVaccineDate(DateTime vaccineDate) {
    emit(ChangeVaccineDateState(vaccineDate));
  }
  changeSelectedBloodType(String bloodType) {
    emit(ChangeSelectedBloodTypeState(bloodType));
  }

  changeRegisterPasswordVisibility(bool visible){
    emit(ChangeRegisterPasswordVisibilityState(visible));
  }

  changeRegisterPasswordVerifyVisibility(bool visible){
    emit(ChangeRegisterPasswordVerifyVisibilityState(visible));
  }

}

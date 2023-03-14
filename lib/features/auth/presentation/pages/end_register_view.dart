import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/font.dart';
import '../../../home/presentation/pages/layout_view.dart';
import '../bloc/auth_cubit.dart';

class EndRegisterScreen extends StatelessWidget {
  final String name,
      nationalId,
      gender,
      birthDate,
      phoneNumber,
      email,
      address,
      governorate,
      city;

  const EndRegisterScreen(
      {Key? key,
      required this.name,
      required this.nationalId,
      required this.gender,
      required this.birthDate,
      required this.phoneNumber,
      required this.email,
      required this.address,
      required this.governorate,
      required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infectionStateController = TextEditingController();
    final takingVaccineController = TextEditingController();
    final vaccineTypeController = TextEditingController();
    final vaccineDateController = TextEditingController();
    final vaccineDoseController = TextEditingController();
    final bloodTypeController = TextEditingController();
    final chronicDiseaseController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordVerifyController = TextEditingController();
    final infectionStateFocusNode = FocusNode();
    final takingVaccineFocusNode = FocusNode();
    final vaccineTypeFocusNode = FocusNode();
    final vaccineDateFocusNode = FocusNode();
    final vaccineDoseFocusNode = FocusNode();
    final bloodTypeFocusNode = FocusNode();
    final chronicDiseaseFocusNode = FocusNode();
    final passwordFocusNode = FocusNode();
    final passwordVerifyFocusNode = FocusNode();
    AuthCubit authCubit = AuthCubit.get(context);
    final List<String> bloodTypes = [
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-',
    ];
    String? bloodType;
    bool passwordVisible = true;
    bool passwordVerifyVisible = true;
    bool isLoading = false;
    DateTime selectedDate = DateTime.now();
    String? vaccineDate;
    return Scaffold(
      backgroundColor: Colors.white,
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),*/
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ChangeVaccineDateState) {
                selectedDate = state.dateTime;
                vaccineDate =
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                vaccineDateController.text = birthDate!;
              } else if (state is ChangeSelectedBloodTypeState) {
                bloodType = state.bloodType;
              } else if (state is ChangeRegisterPasswordVisibilityState) {
                passwordVisible = state.visible;
              } else if (state is ChangeRegisterPasswordVerifyVisibilityState) {
                passwordVerifyVisible = state.visible;
              } else if (state is ErrorCreateAccountState) {
                isLoading = false;
                showToast(msg: state.message, state: ToastStates.error);
              } else if (state is LoadedCreateAccountState) {
                isLoading = false;
                showToast(msg: 'Welcome $name', state: ToastStates.success);
                navigateToAndFinish(context,  LayoutScreen());
              } else if (state is LoadingCreateAccountState) {
                isLoading = true;
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 60.r,
                            height: 60.r,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: customTextField(
                                  controller: infectionStateController,
                                  context: context,
                                  hint: 'Infection state',
                                  label: 'Infection state',
                                  focusNode: infectionStateFocusNode,
                                  icon: Icons.accessibility,
                                  onSubmit: () => FocusScope.of(context)
                                      .requestFocus(takingVaccineFocusNode),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: customTextField(
                                  controller: takingVaccineController,
                                  context: context,
                                  hint: 'Taking vaccine',
                                  label: 'Taking vaccine',
                                  focusNode: takingVaccineFocusNode,
                                  icon: Icons.accessibility,
                                  onSubmit: () => FocusScope.of(context)
                                      .requestFocus(vaccineTypeFocusNode),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: customTextField(
                                  controller: vaccineTypeController,
                                  context: context,
                                  hint: 'Vaccine type',
                                  label: 'Vaccine type',
                                  focusNode: vaccineTypeFocusNode,
                                  icon: Icons.accessibility,
                                  onSubmit: () => FocusScope.of(context)
                                      .requestFocus(vaccineDateFocusNode),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: GestureDetector(
                                    onTap: () async {
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            (DateTime.now().year - 20)),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme: ColorScheme.dark(
                                                primary: defaultColor,
                                                onPrimary: Colors.white,
                                                surface: defaultColor,
                                                onSurface: Colors.black,
                                              ),
                                              dialogBackgroundColor:
                                                  Colors.white,
                                            ),
                                            child: child!,
                                          );
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          authCubit.changeVaccineDate(value);
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vaccine date',
                                            style: openSans(14.sp, defaultColor,
                                                FontWeight.w600),
                                            textScaleFactor: 1,
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h, horizontal: 8.w),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  width: 1.r,
                                                  color: defaultColor),
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.accessibility,
                                                  color: oldSilver,
                                                  size: 20.r,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  vaccineDate ?? 'Vaccine date',
                                                  style: openSans(
                                                      14,
                                                      vaccineDate != null
                                                          ? Colors.black
                                                          : oldSilver,
                                                      vaccineDate != null
                                                          ? FontWeight.w600
                                                          : FontWeight.w300),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: customTextField(
                                  controller: vaccineDoseController,
                                  context: context,
                                  hint: 'Vaccine dose',
                                  label: 'Vaccine dose',
                                  focusNode: vaccineDoseFocusNode,
                                  icon: Icons.accessibility,
                                  onSubmit: () => FocusScope.of(context)
                                      .requestFocus(bloodTypeFocusNode),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Blood type',
                                      style: openSans(
                                          14.sp, defaultColor, FontWeight.w600),
                                      textScaleFactor: 1,
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 1.r, color: defaultColor),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.accessibility,
                                            color: oldSilver,
                                            size: 20.r,
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField(
                                              value: bloodType,
                                              isExpanded: true,
                                              style: openSans(
                                                  14.sp,
                                                  Colors.black,
                                                  FontWeight.w600),
                                              hint: Text(
                                                'Blood type',
                                                textScaleFactor: 1,
                                                style: cairo(14.sp, oldSilver,
                                                    FontWeight.w300),
                                              ),
                                              focusNode: bloodTypeFocusNode,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                              ),
                                              items: bloodTypes
                                                  .map(
                                                    (item) => DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        textScaleFactor: 1,
                                                        style: cairo(
                                                            14.sp,
                                                            Colors.black,
                                                            FontWeight.w400),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  bloodType = value;
                                                  authCubit
                                                      .changeSelectedBloodType(
                                                          value);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customTextField(
                            controller: chronicDiseaseController,
                            context: context,
                            hint: 'Chronic disease',
                            label: 'Chronic disease',
                            focusNode: chronicDiseaseFocusNode,
                            icon: Icons.accessibility,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(passwordFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          passwordTextField(
                            controller: passwordController,
                            context: context,
                            hint: 'Password',
                            label: 'Password',
                            focusNode: passwordFocusNode,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(passwordVerifyFocusNode),
                            obscureText: passwordVisible,
                            onTap: () =>
                                authCubit.changeRegisterPasswordVisibility(
                                    !passwordVisible),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          passwordTextField(
                            controller: passwordVerifyController,
                            context: context,
                            hint: 'Password verify',
                            label: 'Password verify',
                            focusNode: passwordVerifyFocusNode,
                            onSubmit: () => FocusScope.of(context).unfocus(),
                            obscureText: passwordVerifyVisible,
                            onTap: () => authCubit
                                .changeRegisterPasswordVerifyVisibility(
                                    !passwordVerifyVisible),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  defaultButton(
                      onTap: () {
                        if (infectionStateController.text.isNotEmpty &&
                            takingVaccineController.text.isNotEmpty &&
                            vaccineDate != null &&
                            vaccineDoseController.text.isNotEmpty &&
                            bloodType != null &&
                            chronicDiseaseController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            vaccineTypeController.text.isNotEmpty &&
                            passwordVerifyController.text.isNotEmpty) {
                          if (passwordController.text ==
                              passwordVerifyController.text) {
                            authCubit.createAccount(
                              name: name,
                              nationalId: nationalId,
                              gender: gender,
                              birthDate: birthDate,
                              phoneNumber: phoneNumber,
                              email: email,
                              address: address,
                              governorate: governorate,
                              city: city,
                              infectionState: infectionStateController.text,
                              takingVaccine: takingVaccineController.text,
                              vaccineDate: vaccineDate,
                              vaccineDose: vaccineDoseController.text,
                              bloodType: bloodType,
                              chronicDisease: chronicDiseaseController.text,
                              password: passwordController.text,
                              vaccineType: vaccineTypeController.text
                            );
                          } else {
                            showToast(
                                msg: 'passwords are not the same',
                                state: ToastStates.error);
                          }
                        } else {
                          showToast(
                              msg: 'Enter Full Info', state: ToastStates.error);
                        }
                      },
                      text: 'Sign up')
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

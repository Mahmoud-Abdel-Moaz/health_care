import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/colors.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/auth/presentation/pages/end_register_view.dart';

import '../bloc/auth_cubit.dart';

class StartRegisterScreen extends StatelessWidget {
  const StartRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final nationalIdController = TextEditingController();
    final genderController = TextEditingController();
    final birthDateController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final governorateController = TextEditingController();
    final cityController = TextEditingController();
    final nameFocusNode = FocusNode();
    final nationalIdFocusNode = FocusNode();
    final genderFocusNode = FocusNode();
    final birthDateFocusNode = FocusNode();
    final phoneNumberFocusNode = FocusNode();
    final emailFocusNode = FocusNode();
    final addressFocusNode = FocusNode();
    final governorateFocusNode = FocusNode();
    final cityFocusNode = FocusNode();
    DateTime selectedDate = DateTime.now();
    String? birthDate;
   /* String? birthDate =
        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
    birthDateController.text = birthDate;*/
    String? gender;
    List<String> genders = ['male', 'female'];
    AuthCubit authCubit = AuthCubit.get(context);
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
              if (state is ChangeSelectedDateState) {
                selectedDate = state.dateTime;
                 birthDate =
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                birthDateController.text = birthDate!;
              } else if (state is ChangeSelectedGenderState) {
                gender = state.gender;
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
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
                          customTextField(
                            controller: nameController,
                            context: context,
                            hint: 'Name',
                            label: 'Name (Quad)',
                            focusNode: nameFocusNode,
                            icon: Icons.person,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(nationalIdFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customTextField(
                            controller: nationalIdController,
                            context: context,
                            type: const TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            hint: 'National ID',
                            label: 'National ID',
                            focusNode: nationalIdFocusNode,
                            icon: Icons.person,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(genderFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender',
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
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: oldSilver,
                                            size: 20.r,
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField(
                                              value: gender,
                                              isExpanded: true,
                                              style: openSans(14.sp, Colors.black,
                                                  FontWeight.w600),
                                              hint: Text(
                                                'Gender',
                                                textScaleFactor: 1,
                                                style: cairo(14.sp, oldSilver,
                                                    FontWeight.w300),
                                              ),
                                              focusNode: genderFocusNode,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                disabledBorder: InputBorder.none,
                                              ),
                                              items: genders
                                                  .map(
                                                    (item) =>
                                                        DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        textScaleFactor: 1,
                                                        style: cairo(
                                                            14.sp,
                                                            Colors.black,
                                                            FontWeight.w400),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (String? value) {
                                                if (value != null) {
                                                  gender = value;
                                                  authCubit.changeSelectedGender(value);
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
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () async {
                                    print('object');
                                    await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
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
                                            dialogBackgroundColor: Colors.white,
                                          ),
                                          child: child!,
                                        );
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        authCubit.changeSelectedDate(value);
                                      }
                                    });
                                  },
                                  child: /*customTextField(
                                    controller: birthDateController,
                                    context: context,
                                    type: TextInputType.number,
                                    hint: 'Birth Date',
                                    label: 'Birth Date',
                                    enable: false,
                                    focusNode: birthDateFocusNode,
                                    icon: Icons.date_range,
                                    onSubmit: () => FocusScope.of(context)
                                        .requestFocus(phoneNumberFocusNode),
                                  ),*/
                                  Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Birth Date',style: openSans(14.sp, defaultColor, FontWeight.w600),textScaleFactor: 1,),
                                        SizedBox(height: 8.h,),
                                        Container(
                                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(width: 1.r, color: defaultColor),
                                            borderRadius: BorderRadius.circular(12.r),
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.date_range,color: oldSilver,size: 20.r,),
                                              SizedBox(width: 8.w,),
                                              Text(birthDate??'Birth Date',style: openSans(14,birthDate!=null? Colors.black:oldSilver,birthDate!=null? FontWeight.w600:FontWeight.w300),)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customTextField(
                            controller: phoneNumberController,
                            context: context,
                            type: TextInputType.phone,
                            hint: 'PhoneNumber',
                            label: 'PhoneNumber',
                            focusNode: phoneNumberFocusNode,
                            icon: Icons.phone,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(emailFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customTextField(
                            controller: emailController,
                            context: context,
                            type: TextInputType.emailAddress,
                            hint: 'E-mail',
                            label: 'E-mail',
                            focusNode: emailFocusNode,
                            icon: Icons.email,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(addressFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          customTextField(
                            controller: addressController,
                            context: context,
                            type: TextInputType.text,
                            hint: 'Address',
                            label: 'Address',
                            focusNode: addressFocusNode,
                            icon: Icons.location_pin,
                            onSubmit: () => FocusScope.of(context)
                                .requestFocus(governorateFocusNode),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: customTextField(
                                  controller: governorateController,
                                  context: context,
                                  hint: 'Governorate',
                                  label: 'Governorate',
                                  focusNode: governorateFocusNode,
                                  icon: Icons.location_pin,
                                  onSubmit: () => FocusScope.of(context)
                                      .requestFocus(cityFocusNode),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Flexible(
                                child: customTextField(
                                  controller: cityController,
                                  context: context,
                                  hint: 'City',
                                  label: 'City',
                                  focusNode: cityFocusNode,
                                  icon: Icons.location_pin,
                                  onSubmit: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ),
                            ],
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
                        if (nationalIdController.text.isNotEmpty &&
                            nameController.text.isNotEmpty &&
                            gender != null &&
                            birthDate != null &&
                            phoneNumberController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            governorateController.text.isNotEmpty &&
                            cityController.text.isNotEmpty) {
                          navigateTo(
                              context,
                              EndRegisterScreen(
                                name: nameController.text,
                                nationalId: nationalIdController.text,
                                gender: gender!,
                                birthDate: birthDate!,
                                phoneNumber: phoneNumberController.text,
                                email: emailController.text,
                                address: addressController.text,
                                governorate: governorateController.text,
                                city: cityController.text,
                              ));
                        }
                      },
                      text: 'Next'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

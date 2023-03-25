import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/features/emergency/presentation/widgets/emergency_item_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/colors.dart';
import '../../../../core/compnents.dart';
import '../../../../core/constants.dart';
import '../../../../core/font.dart';
import '../../domain/entities/emergency.dart';
import '../bloc/emergency_cubit.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmergencyCubit emergencyCubit = EmergencyCubit.get(context);
    emergencyCubit.getEmergencies();
    List<Emergency>? emergencies = emergencyCubit.emergencies;
    return Scaffold(
      backgroundColor: brightGray,
      appBar:
      defaultAppBar(title: 'Emergency', context: context, withBack: true),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Ambulance',style: openSans(16.sp, Colors.black, FontWeight.w600),textScaleFactor: 1,),
            SizedBox(height: 8.h,),
            defaultButton(onTap: ()=>makeCall('123'), text: 'Call',background: Colors.redAccent),
            SizedBox(height: 16.h,),

            Expanded(
              child: BlocConsumer<EmergencyCubit, EmergencyState>(
                listener: (context, state) {
                  if (state is LoadedEmergenciesState) {
                    emergencies = state.emergencies;
                  }else if(state is LoadedAddEmergencyState){
                    emergencyCubit.getEmergencies();
                  }
                },
                builder: (context, state) {
                  return ConditionalBuilder(
                    condition: emergencies != null,
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                      ),
                    ),
                    builder: (context) => ListView.separated(
                      itemBuilder: (context,index)=>EmergencyItemView(emergency: emergencies![index], number: index+1),
                      separatorBuilder:(context,index)=>SizedBox(height: 16.h,) ,
                      itemCount: emergencies!.length,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: defaultColor,
        onPressed: () => showOptionsSheet(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );

  }

  void showOptionsSheet(BuildContext mainContext) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final nameFocusNode = FocusNode();
    final phoneFocusNode = FocusNode();
    bool isLoading = false;

    EmergencyCubit emergencyCubit = EmergencyCubit.get(mainContext);

    showMaterialModalBottomSheet(
      context: mainContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(62.r),
        ),
      ),
      backgroundColor: lotion,
      builder: (context) => SingleChildScrollView(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: ModalScrollController.of(context),
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              constraints: BoxConstraints(minHeight: 190.h, maxHeight: 523.h),
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 22.h, horizontal: 24.w),
              /* decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50.r),
                ),
              ),*/
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add New Emergency ',
                        style:
                        openSans(16.sp, Colors.black, FontWeight.w600),
                        textScaleFactor: 1,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close,
                          size: 16.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  customTextField(
                    controller: nameController,
                    context: context,
                    hint: 'Name',
                    label: 'Name',
                    focusNode: nameFocusNode,
                    onSubmit: () =>
                        FocusScope.of(context).requestFocus(phoneFocusNode),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  customTextField(
                    controller: phoneController,
                    context: context,
                    hint: 'Phone number',
                    label: 'Phone number',
                    type:TextInputType.phone,
                    focusNode: phoneFocusNode,
                    onSubmit: () =>
                        FocusScope.of(context).unfocus(),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  defaultButton(onTap: (){
                    if(!isLoading){
                      if(nameController.text.isNotEmpty&&phoneController.text.isNotEmpty){
                        emergencyCubit.addEmergency(name: nameController.text, phone: phoneController.text);
                        Navigator.of(mainContext).pop();
                      }else {
                        showToast(msg: 'Enter All Info', state: ToastStates.error);
                      }
                    }
                  }, text: 'ADD EMERGENCY',isLoading: isLoading),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}

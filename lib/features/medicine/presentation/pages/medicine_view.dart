import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/font.dart';
import 'package:health_care/features/medicine/presentation/bloc/medicine_cubit.dart';
import 'package:health_care/features/medicine/presentation/widgets/medicine_item_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/medicine.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MedicineCubit medicineCubit = MedicineCubit.get(context);
    medicineCubit.getMedicines();
    List<Medicine>? medicines = medicineCubit.medicines;
    return Scaffold(
      backgroundColor: brightGray,
      appBar:
          defaultAppBar(title: 'Medicine', context: context, withBack: true),
      body: BlocConsumer<MedicineCubit, MedicineState>(
        listener: (context, state) {
          if (state is LoadedMedicinesState) {
            medicines = state.medicines;
          }else if(state is LoadedAddMedicineState){
            medicineCubit.getMedicines();
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: medicines != null,
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
            builder: (context) => GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                  mainAxisSpacing:16,
                  crossAxisSpacing:16,
              ),

              itemCount: medicines!.length,
              itemBuilder: (BuildContext context, int index) =>
                  MedicineItemView(medicine: medicines![index]),
            ),
          );
        },
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
    final doesController = TextEditingController();
    final timeController = TextEditingController();
    final nameFocusNode = FocusNode();
    final doesFocusNode = FocusNode();
    final timeFocusNode = FocusNode();
    bool isLoading = false;
    TimeOfDay? selectedTime;
    String? selectedShape;
    MedicineCubit medicineCubit = MedicineCubit.get(mainContext);
    
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
              child: BlocConsumer<MedicineCubit, MedicineState>(
                listener: (context, state) {
                  if(state is ChangeSelectedTimeState){
                    selectedTime=state.timeOfDay;
                    timeController.text='${selectedTime!.hour}:${selectedTime!.minute}';
                  }else if(state is ChangeSelectedShapeState){
                    selectedShape=state.shape;
                  }else if(state is LoadedAddMedicineState){
                    isLoading=false;
                    nameController.clear();
                    doesController.clear();
                    timeController.clear();
                    selectedTime=null;
                    selectedShape=null;
                    medicineCubit.getMedicines();
                  }else if(state is LoadingAddMedicineState){
                    isLoading=true;
                  }else if(state is ErrorAddMedicineState){
                    isLoading=false;
                    showToast(msg: state.message, state: ToastStates.error);
                  }
                },
                builder: (context, state) {
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add New Medicine',
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
                            FocusScope.of(context).requestFocus(doesFocusNode),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      customTextField(
                        controller: doesController,
                        context: context,
                        hint: 'Does',
                        label: 'Does',
                        type:const TextInputType.numberWithOptions(decimal: false,signed: false),
                        focusNode: doesFocusNode,
                        onSubmit: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: ()async{
                          final TimeOfDay? newTime = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 7, minute: 15),
                          );
                          if(newTime!=null){
                              medicineCubit.changeSelectedTime(newTime);
                          }
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
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
                                child: Text(selectedTime!=null?timeController.text:'Time',
                                  style: openSans(
                                      14,
                                      selectedTime != null
                                          ? Colors.black
                                          : oldSilver,
                                      selectedTime != null
                                          ? FontWeight.w600
                                          : FontWeight.w300),
                                ),
                              ),
                            ],
                          ),
                        )


                        /*customTextField(
                          controller: timeController,
                          context: context,
                          enable: false,
                          hint: 'Time',
                          label: 'Time',
                          focusNode: timeFocusNode,
                          onSubmit: () =>
                              FocusScope.of(context).unfocus(),
                        )*/,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          shapeItem('bandage',  selectedShape, medicineCubit),
                          shapeItem('capsule',  selectedShape, medicineCubit),
                          shapeItem('inhaler',  selectedShape, medicineCubit),
                          shapeItem('injection',  selectedShape, medicineCubit),
                          shapeItem('tablet',  selectedShape, medicineCubit),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      defaultButton(onTap: (){
                        if(!isLoading){
                          if(nameController.text.isNotEmpty&&doesController.text.isNotEmpty&&selectedShape!=null&&selectedTime!=null){
                            medicineCubit.addMedicine(name: nameController.text, shape: selectedShape!, dose: doesController.text, hour: selectedTime!.hour, minute: selectedTime!.minute);
                          }else {
                            showToast(msg: 'Enter All Info', state: ToastStates.error);
                          }
                        }
                      }, text: 'ADD MEDICINE',isLoading: isLoading),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
  
  shapeItem(String shape,String? selectedShape,MedicineCubit medicineCubit){
    return Flexible(child: GestureDetector(
      onTap: ()=>medicineCubit.changeSelectedShape(shape),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 4.w),
        decoration: BoxDecoration(
          color: selectedShape==shape?wildBlueYonder:Colors.transparent,
          shape: BoxShape.circle,
        ),
child:ImageIcon(AssetImage('assets/images/medicine/${shape}.png'),color: defaultColor,size: 60.r,),

      ),
    ),);
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/core/constants.dart';
import 'package:health_care/core/local_notification_service.dart';

import '../../../../core/cache_helper.dart';
import '../../data/models/medicine_model.dart';
import '../../domain/entities/medicine.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());

  static MedicineCubit get(context) => BlocProvider.of(context);
  List<Medicine>? medicines;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getMedicines() async {
    try {
      emit(LoadingMedicinesState());
      QuerySnapshot querySnapshot = await _firestore
          .collection('medicines')
          .doc(userId)
          .collection('medicines')
          .get();
      medicines = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
        medicines!.add(MedicineModel.fromJson(map));
      }
      emit(LoadedMedicinesState(medicines!));
    } catch (e) {
      emit(ErrorMedicinesState(e.toString()));
      print('Error getMedicines: $e');
    }
  }

  addMedicine({
    required String name,
    required String shape,
    required String dose,
    required int hour,
    required int minute,
  }) async {
    try {
      emit(LoadingAddMedicineState());
      final CollectionReference myCollection = _firestore
          .collection('medicines')
          .doc(userId)
          .collection('medicines');
      final DocumentReference newDocRef = myCollection.doc();
      final String newDocId = newDocRef.id;
      await _firestore
          .collection('medicines')
          .doc(userId)
          .collection('medicines')
          .doc(newDocId)
          .set(MedicineModel(newDocId, name, shape, dose, hour, minute, userId!,
                  notificationId)
              .toJson());
      _addNotification(notificationId, name, dose, hour, minute);
      notificationId = notificationId + 1;
      CacheHelper.saveData(key: 'notification_id', value: notificationId);
      emit(LoadedAddMedicineState());
    } catch (e) {
      emit(ErrorAddMedicineState(e.toString()));
      print('Error addMedicine $e');
    }
  }

  void _addNotification(
      int notificationId, String name, String dose, int hour, int minute) {
    DateTime currentTime = DateTime.now();
    DateTime medicineTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, hour, minute, 0, 0, 0);
    if (currentTime.isBefore(medicineTime)) {
      LocalNotificationService.setNotification(
        time: medicineTime,
        id: notificationId,
        title: name,
        body: dose,
      );
    } else {
      LocalNotificationService.setNotification(
        time: medicineTime.add(const Duration(days: 1)),
        id: notificationId,
        title: name,
        body: dose,
      );
    }
  }

  changeSelectedTime(TimeOfDay timeOfDay) {
    emit(ChangeSelectedTimeState(timeOfDay));
  }

  changeSelectedShape(String shape) {
    emit(ChangeSelectedShapeState(shape));
  }
}

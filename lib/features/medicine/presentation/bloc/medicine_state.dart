part of 'medicine_cubit.dart';

abstract class MedicineState extends Equatable {
  const MedicineState();
}

class MedicineInitial extends MedicineState {
  @override
  List<Object> get props => [];
}

class LoadingMedicinesState extends MedicineState {
  @override
  List<Object> get props => [];
}

class ErrorMedicinesState extends MedicineState {
  final String message;

  const ErrorMedicinesState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedMedicinesState extends MedicineState {
  final List<Medicine> medicines;

  const LoadedMedicinesState(this.medicines);

  @override
  List<Object> get props => [medicines];
}

class LoadingAddMedicineState extends MedicineState {
  @override
  List<Object> get props => [];
}

class ErrorAddMedicineState extends MedicineState {
  final String message;

  const ErrorAddMedicineState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadedAddMedicineState extends MedicineState {
  @override
  List<Object> get props => [];
}

class ChangeSelectedTimeState extends MedicineState{
  final TimeOfDay timeOfDay;

  const ChangeSelectedTimeState(this.timeOfDay);

  @override
  List<Object?> get props => [timeOfDay];
}

class ChangeSelectedShapeState extends MedicineState{
  final String shape;

  const ChangeSelectedShapeState(this.shape);

  @override
  List<Object?> get props => [shape];
}

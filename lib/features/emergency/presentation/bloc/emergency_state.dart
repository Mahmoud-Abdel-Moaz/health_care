part of 'emergency_cubit.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();
}

class EmergencyInitial extends EmergencyState {
  @override
  List<Object> get props => [];
}

class LoadingEmergenciesState extends EmergencyState {
  @override
  List<Object> get props => [];
}

class LoadedEmergenciesState extends EmergencyState {
  final List<Emergency> emergencies;

  const LoadedEmergenciesState(this.emergencies);
  @override
  List<Object> get props => [emergencies];
}

class ErrorEmergenciesState extends EmergencyState {
  final String message;

  const ErrorEmergenciesState(this.message);
  @override
  List<Object> get props => [message];
}

class LoadingAddEmergencyState extends EmergencyState {
  @override
  List<Object> get props => [];
}

class LoadedAddEmergencyState extends EmergencyState {

  @override
  List<Object> get props => [];
}

class ErrorAddEmergencyState extends EmergencyState {
  final String message;

  const ErrorAddEmergencyState(this.message);
  @override
  List<Object> get props => [message];
}

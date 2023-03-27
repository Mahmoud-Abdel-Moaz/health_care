part of 'first_aid_cubit.dart';

abstract class FirstAidState extends Equatable {
  const FirstAidState();
}

class FirstAidInitial extends FirstAidState {
  @override
  List<Object> get props => [];
}


class LoadingFirstAidsState extends FirstAidState {
  @override
  List<Object> get props => [];
}

class LoadedFirstAidsState extends FirstAidState {
  final List<FirstAid> firstAids;

  const LoadedFirstAidsState(this.firstAids);
  @override
  List<Object> get props => [firstAids];
}

class ErrorFirstAidsState extends FirstAidState {
  final String message;

  const ErrorFirstAidsState(this.message);
  @override
  List<Object> get props => [message];
}


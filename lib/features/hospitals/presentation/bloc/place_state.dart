part of 'place_cubit.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlaceInitial extends PlaceState {
  @override
  List<Object> get props => [];
}

class LoadingPlacesState extends PlaceState {
  @override
  List<Object> get props => [];
}

class LoadedPlacesState extends PlaceState {
  final List<Place> places;

  const LoadedPlacesState(this.places);
  @override
  List<Object> get props => [places];
}

class ErrorPlacesState extends PlaceState {
  final String message;

  const ErrorPlacesState(this.message);
  @override
  List<Object> get props => [message];
}

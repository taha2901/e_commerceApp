part of 'address_cubit.dart';

sealed class ChooseLocationState {}

final class ChooseLocationInitial extends ChooseLocationState {}

final class FetchingLocations extends ChooseLocationState {}

final class FetchedLocations extends ChooseLocationState {
  final List<LocationItemModel> locations;

  FetchedLocations(this.locations);
}

final class FetchLocationsFailure extends ChooseLocationState {
  final String errorMessage;

  FetchLocationsFailure(this.errorMessage);
}

final class AddingLocation extends ChooseLocationState {}

final class LocationAdded extends ChooseLocationState {}

final class LocationAddingFailure extends ChooseLocationState {
  final String errorMessage;

  LocationAddingFailure(this.errorMessage);
}

final class LocationChosen extends ChooseLocationState {
  final LocationItemModel location;

  LocationChosen(this.location);
}

final class ConfirmAddressLoading extends ChooseLocationState {}

final class ConfirmAddressLoaded extends ChooseLocationState {}

final class ConfirmAddressFailure extends ChooseLocationState {
  final String errorMessage;

  ConfirmAddressFailure(this.errorMessage);
}
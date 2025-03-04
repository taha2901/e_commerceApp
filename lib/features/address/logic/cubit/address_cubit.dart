import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/address/data/location_item_model.dart';

part 'address_state.dart';

class ChooseLocationCubit extends Cubit<ChooseLocationState> {
  ChooseLocationCubit() : super(ChooseLocationInitial());

  String selectedLocationId = dummyLocations.first.id;

  void fetchLocations() {
    emit(FetchingLocations());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        emit(FetchedLocations(dummyLocations));
      },
    );
  }

  void addLocation(String location) {
    emit(AddingLocation());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        final splittedLocations = location.split('-');
        final locationItem = LocationItemModel(
          id: DateTime.now().toIso8601String(),
          city: splittedLocations[0],
          country: splittedLocations[1],
        );
        dummyLocations.add(locationItem);
        emit(LocationAdded());
        emit(FetchedLocations(dummyLocations));
      },
    );
  }

  void selectLocation(String id) {
    selectedLocationId = id;
    final chosenLocation = dummyLocations
        .firstWhere((location) => location.id == selectedLocationId);
    emit(LocationChosen(chosenLocation));
  }

  void confirmAddress() {
    emit(ConfirmAddressLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        var chosenAddress = dummyLocations
            .firstWhere((location) => location.id == selectedLocationId);
        var previousAddress = dummyLocations.firstWhere(
          (location) => location.isChosen == true,
          orElse: () => dummyLocations.first,
        );
        previousAddress = previousAddress.copyWith(isChosen: false);
        chosenAddress = chosenAddress.copyWith(isChosen: true);
        final previousIndex = dummyLocations
            .indexWhere((location) => location.id == previousAddress.id);
        final chosenIndex = dummyLocations
            .indexWhere((location) => location.id == chosenAddress.id);
        dummyLocations[previousIndex] = previousAddress;
        dummyLocations[chosenIndex] = chosenAddress;
        emit(ConfirmAddressLoaded());
      },
    );
  }
}
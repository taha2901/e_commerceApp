import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home/data/home_carousal_item_model.dart';
import 'package:ecommerce_app/features/home/data/product_items_model.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getHomeData() {
    emit(HomeLoading());
    Future.delayed(const Duration(seconds: 1), () {
      emit(HomeLoaded(
        carouselItems: dummyHomeCarouselItems,
        products: dummyProducts,
      ));
    });
  }
}

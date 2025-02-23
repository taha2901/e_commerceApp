import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int quantity = 1;

  void getCartItems() async {
    emit(CartLoading());
    emit(CartLoaded(dummyCart, _subTotal));
  }

  void incrementCounter(String productId, [int? initialValue]) { 
    //في حال تمرير initialValue، سيتم استخدامه بدلاً من القيمة الحالية.
    if (initialValue != null) quantity = initialValue;
    quantity++;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    // السطرين اللي فوق دول بجيب العنصر اللي بزود فيه الكمية بعدين اخزنو ف الكارت
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubTotalUpdated(_subTotal));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) quantity = initialValue;
    quantity--;
    final index = dummyCart.indexWhere((item) => item.product.id == productId);
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    emit(QuantityCounterLoaded(value: quantity, productId: productId));
    emit(SubTotalUpdated(_subTotal));
  }

  double get _subTotal => dummyCart.fold<double>(
        0,
        (previousValue, item) =>
            previousValue + (item.product.price * item.quantity),
      );
}

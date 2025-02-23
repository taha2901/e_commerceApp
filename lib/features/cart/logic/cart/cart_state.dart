part of 'cart_cubit.dart';

@immutable
sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;

  const CartLoaded(this.cartItems, this.subtotal);
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);
}

final class QuantityCounterLoaded extends CartState {
  final int value;
  final String productId; // بنعمل كدا عشان لما نزود او نقلل يبقا للعنصر بتاعنا فقط مش لكل العناصر 

  const QuantityCounterLoaded( {required this.value, required this.productId});
}


final class SubTotalUpdated extends CartState {
  final double subtotal;

  const SubTotalUpdated(this.subtotal);
}
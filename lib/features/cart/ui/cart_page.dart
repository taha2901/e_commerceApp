import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/cart/logic/cart/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widget/cart_item.dart';
import 'package:ecommerce_app/features/home/data/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint(dummyCart.toString());
    return BlocProvider(
      create: (context) {
        final cubit = CartCubit();
        cubit.getCartItems();
        return cubit;
      },
      child: Builder(builder: (context) {
        final cubit = BlocProvider.of<CartCubit>(context);
        return BlocBuilder<CartCubit, CartState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is CartLoaded ||
              current is CartLoading ||
              current is CartError ||
              current is CartError,
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is CartLoaded) {
              final cartItems = state.cartItems;
              if (cartItems.isEmpty) {
                return const Center(
                  child: Text('No items in your cart!'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return CartItemWidget(cartItem: cartItem);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColors.grey2,
                        );
                      },
                    ),
                    Divider(
                      color: AppColors.grey2,
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          current is SubTotalUpdated,
                      builder: (context, subtotalState) {
                        if (subtotalState is SubTotalUpdated) {
                          return Column(
                            children: [
                              totalAndSubtotalWidget(context,
                                  title: 'Subtotal',
                                  amount: subtotalState.subtotal),
                              totalAndSubtotalWidget(context,
                                  title: 'Shipping', amount: 10),
                              const SizedBox(height: 4.0),
                              Dash(
                                dashColor: AppColors.grey3,
                                length: MediaQuery.of(context).size.width - 32,
                              ),
                              const SizedBox(height: 4.0),
                              totalAndSubtotalWidget(
                                context,
                                title: 'Total Amount',
                                amount: subtotalState.subtotal + 10,
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            totalAndSubtotalWidget(context,
                                title: 'Subtotal', amount: state.subtotal),
                            totalAndSubtotalWidget(context,
                                title: 'Shipping', amount: 10),
                            const SizedBox(height: 4.0),
                            Dash(
                              dashColor: AppColors.grey3,
                              length: MediaQuery.of(context).size.width - 32,
                            ),
                            const SizedBox(height: 4.0),
                            totalAndSubtotalWidget(
                              context,
                              title: 'Total Amount',
                              amount: state.subtotal + 10,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(Routers.checkoutRoute);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Checkout'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          },
        );
      }),
    );
  }

  Widget totalAndSubtotalWidget(context,
      {required String title, required double amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.grey),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
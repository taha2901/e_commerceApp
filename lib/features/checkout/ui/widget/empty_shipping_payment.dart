import 'package:ecommerce_app/core/routings/routers.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/features/checkout/logic/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingAndPayment extends StatelessWidget {
  final String title;
  final bool isPayment;
  const EmptyShippingAndPayment({
    super.key,
    required this.title,
    required this.isPayment,
  });

  @override
  Widget build(BuildContext context) {
    final paymentCubit = BlocProvider.of<CheckoutCubit>(context);
    return InkWell(
      onTap: () {
        if (isPayment) {
          Navigator.of(context)
              .pushNamed(Routers.addNewCardRoute)
              .then((value) => paymentCubit.getCartItems());
        } else {
          Navigator.of(context)
              .pushNamed(Routers.chooseLocation)
              .then((value) => paymentCubit.getCartItems());
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grey3,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              const Icon(
                Icons.add,
                size: 30,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

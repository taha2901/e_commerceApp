import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/cart/data/payment_card_model.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  String selectedPaymentId = dummyPaymentCards.first.id;

  void addNewCard(
      String cardNumber, String cardHolderName, String expiryDate, String cvv) {
    emit(AddNewCardLoading());
    final newCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardNumber: cardNumber,
      cardHolderName: cardHolderName,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        dummyPaymentCards.add(newCard);
        emit(AddNewCardSuccess());
      },
    );
  }

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (dummyPaymentCards.isNotEmpty) {
          final chosenPaymentMethods = dummyPaymentCards.firstWhere(
              (paymentCard) => paymentCard.isChosen == true,
              orElse: () => dummyPaymentCards.first);
          emit(FetchedPaymentMethods(dummyPaymentCards));
          emit(PayemntChosen(chosenPayment: chosenPaymentMethods));
        } else {
          emit(FetchPaymentMethodsError('No payment methods found'));
        }
      },
    );
  }

  // void choosePaymentMethod(String id) {
  //   var chosenPaymentMethod =
  //       dummyPaymentCards.firstWhere((paymentCard) => paymentCard.id == id);
  //   var previousPaymentMethods = dummyPaymentCards
  //       .firstWhere((paymentCard) => paymentCard.isChosen == true,
  //           orElse: () => dummyPaymentCards.first);
  //   previousPaymentMethods = previousPaymentMethods.copyWith(isChosen: false);
  //   chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
  //   Future.delayed(
  //     const Duration(seconds: 1),
  //     () {
  //       emit(PayemntChosen(chosenPayment: chosenPaymentMethod));
  //     },
  //   );
  // }

  void changePaymentMethod(String id) {
    selectedPaymentId = id;
    var tempChosenPaymentMethod = dummyPaymentCards
        .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
    emit(PayemntChosen(chosenPayment: tempChosenPaymentMethod));
  }

  void confirmPaymentMethod() {
    emit(ConfirmPaymentLoading());
    Future.delayed(
      const Duration(seconds: 1),
      () {
        var chosenPaymentMethod = dummyPaymentCards
            .firstWhere((paymentCard) => paymentCard.id == selectedPaymentId);
        var previousPaymentMethod = dummyPaymentCards.firstWhere(
          (paymentCard) => paymentCard.isChosen == true,
          orElse: () => dummyPaymentCards.first,
        );
        previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
        chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
        final previousIndex = dummyPaymentCards.indexWhere(
            (paymentCard) => paymentCard.id == previousPaymentMethod.id);
        final chosenIndex = dummyPaymentCards.indexWhere(
            (paymentCard) => paymentCard.id == chosenPaymentMethod.id);
        dummyPaymentCards[previousIndex] = previousPaymentMethod;
        dummyPaymentCards[chosenIndex] = chosenPaymentMethod;
        emit(ConfirmPaymentSuccess());
      },
    );
  }
}

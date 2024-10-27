part of 'payment_cubit.dart';



abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}
class PaymentOtpSent extends PaymentState {}
class PaymentOtpVerified extends PaymentState {}
class PaymentProcessing extends PaymentState {}
class PaymentCompleted extends PaymentState {}
class PaymentError extends PaymentState {
  final String message;
  PaymentError(this.message);

  @override
  List<Object> get props => [message];
}

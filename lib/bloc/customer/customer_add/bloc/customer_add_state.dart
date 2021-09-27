part of 'customer_add_bloc.dart';

@immutable
abstract class CustomerAddState {}

class CustomerAddInitial extends CustomerAddState {}

class CustomerAddLoading extends CustomerAddState {}

class CustomerAddSuccess extends CustomerAddState {
  final String succMsg;
  CustomerAddSuccess({required this.succMsg});
}

class CustomerAddFaillure extends CustomerAddState {
  final String errMsg;
  CustomerAddFaillure({required this.errMsg});
}

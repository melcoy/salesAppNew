part of 'list_customer_bloc.dart';

@immutable
abstract class ListCustomerState {}

class ListCustomerInitial extends ListCustomerState {}

class ListCustomerLoading extends ListCustomerState {}

class ListCustomerLoadingSearch extends ListCustomerState {}

class ListCustomerFailure extends ListCustomerState {
  final String errorMessage;

  ListCustomerFailure(this.errorMessage);
}

class ListCustomerLoaded extends ListCustomerState {
  final List<ListCustomerModel> listCustomerModel;

  ListCustomerLoaded(this.listCustomerModel);
}

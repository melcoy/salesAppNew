part of 'list_customer_bloc.dart';

@immutable
abstract class ListCustomerEvent {}

class ListCustomerEventStarted extends ListCustomerEvent {}

class ListCustomerEventSearch extends ListCustomerEvent {
  final List<ListCustomerModel> model;
  final String searchKey;
  ListCustomerEventSearch({required this.model, required this.searchKey});
}

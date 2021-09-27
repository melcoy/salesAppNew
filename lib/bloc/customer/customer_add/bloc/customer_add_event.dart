part of 'customer_add_bloc.dart';

@immutable
abstract class CustomerAddEvent {}

class CustomerAddBlocEventSave extends CustomerAddEvent {
  final CustomerAddDto model;

  CustomerAddBlocEventSave(this.model);
}

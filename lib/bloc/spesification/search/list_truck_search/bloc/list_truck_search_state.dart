part of 'list_truck_search_bloc.dart';

@immutable
abstract class ListTruckSearchState {}

class ListTruckSearchInitial extends ListTruckSearchState {}

class ListTruckSearchLoaded extends ListTruckSearchState {
  final List<ListAllTruckModel> listAllProduct;
  ListTruckSearchLoaded({required this.listAllProduct});
}

class ListTruckSearchFaillure extends ListTruckSearchState {
  final String errMsg;
  ListTruckSearchFaillure({required this.errMsg});
}

class ListTruckSearchLoading extends ListTruckSearchState {}

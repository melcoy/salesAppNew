part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<KotaModel> model;
  CityLoaded({required this.model});
}

class CityFaillure extends CityState {
  final String errMsg;
  CityFaillure({required this.errMsg});
}

class CityLoadingSearch extends CityState {}

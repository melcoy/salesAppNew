part of 'province_bloc.dart';

@immutable
abstract class ProvinceState {}

class ProvinceInitial extends ProvinceState {}

class ProvinceFaillure extends ProvinceState {
  final String errMsg;
  ProvinceFaillure({required this.errMsg});
}

class ProvinceLoaded extends ProvinceState {
  final List<ProvinsiModel> model;
  ProvinceLoaded({required this.model});
}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoadingSearch extends ProvinceState {}

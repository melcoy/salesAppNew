part of 'province_bloc.dart';

@immutable
abstract class ProvinceEvent {}

class ProvinceEventStarted extends ProvinceEvent {}

class ProvinceEventSearch extends ProvinceEvent {
  final List<ProvinsiModel> model;
  final String searchKey;
  ProvinceEventSearch({required this.model, required this.searchKey});
}

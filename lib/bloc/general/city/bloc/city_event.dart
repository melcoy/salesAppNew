part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class CityEventStarted extends CityEvent {}

class CityEventSearch extends CityEvent {
  final List<KotaModel> model;
  final String searchKey;
  CityEventSearch({required this.model, required this.searchKey});
}

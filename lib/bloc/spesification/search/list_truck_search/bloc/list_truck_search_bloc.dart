import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/Spesification/spesification_repo.dart';
import 'package:sales_app/models/spesification/list_all_truck_model.dart';

part 'list_truck_search_event.dart';
part 'list_truck_search_state.dart';

class ListTruckSearchBloc
    extends Bloc<ListTruckSearchEvent, ListTruckSearchState> {
  ListTruckSearchBloc() : super(ListTruckSearchInitial());
  final SpesificationRepo _spesificationRepo = SpesificationRepo();

  @override
  Stream<ListTruckSearchState> mapEventToState(
    ListTruckSearchEvent event,
  ) async* {
    if (event is ListTruckSearchEventStarted) {
      yield ListTruckSearchLoading();
      List<dynamic> listAllProduct =
          await _spesificationRepo.fetchAllProductDetail();
      if (listAllProduct[0] == true) {
        List<ListAllTruckModel> result = listAllProduct[1];
        result.sort((a, b) => a.name.compareTo(b.name));
        yield ListTruckSearchLoaded(listAllProduct: result);
      } else {
        yield ListTruckSearchFaillure(errMsg: listAllProduct[1]);
      }
    }
  }
}

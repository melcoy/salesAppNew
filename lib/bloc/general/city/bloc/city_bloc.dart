import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/general/general_repo.dart';
import 'package:sales_app/models/general/kota_model.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityInitial());
  GeneralRepo generalRepo = GeneralRepo();
  @override
  Stream<CityState> mapEventToState(
    CityEvent event,
  ) async* {
    if (event is CityEventStarted) {
      List<dynamic> result = await generalRepo.fetchgetListKota();

      if (result[0] == true) {
        List<KotaModel> model = result[1];
        model.sort((a, b) => a.name.compareTo(b.name));
        yield CityLoaded(model: model);
      } else {
        yield CityFaillure(errMsg: result[1].toString());
      }
    }

    if (event is CityEventSearch) {
      List<KotaModel> modelSearch = [];
      yield CityLoading();
      modelSearch = await loopSearch(event.searchKey, event.model);
      yield CityLoaded(model: modelSearch);
    }
  }
}

Future<List<KotaModel>> loopSearch(String key, List<KotaModel> list) async {
  List<KotaModel> modelSearch = [];
  for (var i = 0; i < list.length; i++) {
    if (list[i].name.toLowerCase().contains(key)) {
      modelSearch.add(list[i]);
    }
  }
  return modelSearch;
}

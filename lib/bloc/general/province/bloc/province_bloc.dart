import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/general/general_repo.dart';
import 'package:sales_app/models/general/provinsi_model.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(ProvinceInitial());
  GeneralRepo generalRepo = GeneralRepo();
  @override
  Stream<ProvinceState> mapEventToState(
    ProvinceEvent event,
  ) async* {
    if (event is ProvinceEventStarted) {
      print("masuk");
      yield ProvinceLoading();
      List<dynamic> result = await generalRepo.fetchGetListProv();

      if (result[0] == true) {
        List<ProvinsiModel> provModel = result[1];
        provModel.sort((a, b) => a.name.compareTo(b.name));
        yield ProvinceLoaded(model: provModel);
      } else {
        yield ProvinceFaillure(errMsg: result[1].toString());
      }
    }

    if (event is ProvinceEventSearch) {
      List<ProvinsiModel> modelSearch = [];
      yield ProvinceLoading();
      modelSearch = await loopSearch(event.searchKey, event.model);
      yield ProvinceLoaded(model: modelSearch);
    }
  }
}

Future<List<ProvinsiModel>> loopSearch(
    String key, List<ProvinsiModel> list) async {
  List<ProvinsiModel> modelSearch = [];
  for (var i = 0; i < list.length; i++) {
    if (list[i].name.toLowerCase().contains(key)) {
      modelSearch.add(list[i]);
    }
  }
  return modelSearch;
}

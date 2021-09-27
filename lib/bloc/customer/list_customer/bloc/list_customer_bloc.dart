import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/customer/customer_repo.dart';
import 'package:sales_app/models/customer/list_customer_model.dart';

part 'list_customer_event.dart';
part 'list_customer_state.dart';

class ListCustomerBloc extends Bloc<ListCustomerEvent, ListCustomerState> {
  ListCustomerBloc() : super(ListCustomerInitial());
  CustomerRepo _customerRepo = CustomerRepo();

  @override
  Stream<ListCustomerState> mapEventToState(
    ListCustomerEvent event,
  ) async* {
    if (event is ListCustomerEventStarted) {
      yield ListCustomerLoading();
      List<dynamic> result = await _customerRepo.fetchListCustomer();
      if (result[0] == true) {
        List<ListCustomerModel> listModel = result[1];

        listModel.sort((a, b) => a.name.compareTo(b.name));
        yield ListCustomerLoaded(listModel);
      } else {
        yield ListCustomerFailure(result[1].toString());
      }
    }
    if (event is ListCustomerEventSearch) {
      List<ListCustomerModel> modelSearch = [];
      yield ListCustomerLoading();
      modelSearch = await loopSearch(event.searchKey, event.model);
      yield ListCustomerLoaded(modelSearch);
    }
  }
}

Future<List<ListCustomerModel>> loopSearch(
    String key, List<ListCustomerModel> list) async {
  List<ListCustomerModel> modelSearch = [];
  for (var i = 0; i < list.length; i++) {
    if (list[i].name.toLowerCase().contains(key)) {
      modelSearch.add(list[i]);
    }
  }
  return modelSearch;
}

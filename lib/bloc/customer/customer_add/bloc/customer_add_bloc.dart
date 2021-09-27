import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/customer/customer_repo.dart';
import 'package:sales_app/models/customer/customer_add_model.dart';
import 'package:sales_app/models/customer/dto/customer_add_dto.dart';

part 'customer_add_event.dart';
part 'customer_add_state.dart';

class CustomerAddBloc extends Bloc<CustomerAddEvent, CustomerAddState> {
  CustomerAddBloc() : super(CustomerAddInitial());
  CustomerRepo customerRepo = CustomerRepo();

  @override
  Stream<CustomerAddState> mapEventToState(
    CustomerAddEvent event,
  ) async* {
    if (event is CustomerAddBlocEventSave) {
      yield CustomerAddLoading();
      String sex;
      if (event.model.sex.contains("Men")) {
        sex = "P";
      } else {
        sex = "W";
      }
      CustomerAddModel model = CustomerAddModel(
          name: event.model.name,
          alamat: event.model.alamat,
          decisionmaker: "1",
          email: event.model.email,
          hp: event.model.hp,
          kecamatan: "",
          kelurahan: "",
          kodepos: "",
          kota: event.model.kota,
          provinsi: event.model.provinsi,
          sex: sex);

      bool saved = await customerRepo.fetchAddCustomer(model);
      if (saved == false) {
        yield CustomerAddFaillure(errMsg: "Failed Created Customer, Try Again");
      } else {
        yield CustomerAddSuccess(succMsg: "Data has been saved");
      }
    }
  }
}

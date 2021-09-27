import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/Spesification/spesification_repo.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_bloc/bloc/visit_plan_bloc.dart';
import 'package:sales_app/models/spesification/list_all_truck_model.dart';
import 'package:sales_app/models/visit_plan/dto/visit_plan_saved_dto.dart';

part 'visit_plan_sales_event.dart';
part 'visit_plan_sales_state.dart';

class VisitPlanSalesBloc
    extends Bloc<VisitPlanSalesEvent, VisitPlanSalesState> {
  VisitPlanSalesBloc() : super(VisitPlanSalesInitial());
  final SpesificationRepo _spesificationRepo = SpesificationRepo();

  final VisitPlanRepo _visitPlanRepo = VisitPlanRepo();
  @override
  Stream<VisitPlanSalesState> mapEventToState(
    VisitPlanSalesEvent event,
  ) async* {
    if (event is VisitPlanSalesEventSaved) {
      yield VisitPlanSalesLoading();
      bool saved = await _visitPlanRepo.fetchAddSales(event.model);
      bool savedVP = await _visitPlanRepo.fetchUpdateStatusVisitPlan(
          "5", event.model.visitplan);

      if (saved == false && savedVP == false) {
        yield VisitPlanSalesFailure(
            errMsg: "Sales Input Failed, Please Try Again Later");
      } else {
        yield VisitPlanSalesSaved(savedMsg: "Sales has succesfully added");
      }
    }
  }
}

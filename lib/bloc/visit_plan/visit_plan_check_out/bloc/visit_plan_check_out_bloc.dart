import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/util/get_location.dart';

part 'visit_plan_check_out_event.dart';
part 'visit_plan_check_out_state.dart';

class VisitPlanCheckOutBloc
    extends Bloc<VisitPlanCheckOutEvent, VisitPlanCheckOutState> {
  VisitPlanCheckOutBloc() : super(VisitPlanCheckOutInitial());
  final GetLocation _getLocation = GetLocation();
  VisitPlanRepo visitPlanRepo = VisitPlanRepo();
  @override
  Stream<VisitPlanCheckOutState> mapEventToState(
    VisitPlanCheckOutEvent event,
  ) async* {
    if (event is VisitPlanCheckOutPressed) {
      yield VisitPlanCheckOutStateLoading();

      var loc = await _getLocation.getLocation();
      bool result = await visitPlanRepo.fetchCheckout(
          loc[0].toString(), loc[1].toString(), event.dto.idVisitPlan);
      if (result) {
        yield VisitPlanCheckOutStateSuccess();
      } else {
        yield VisitPlanCheckOutStateFaillure("Error");
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/visit_plan/visit_plan_add_model.dart';

part 'visit_plan_add_event.dart';
part 'visit_plan_add_state.dart';

class VisitPlanAddBloc extends Bloc<VisitPlanAddEvent, VisitPlanAddState> {
  VisitPlanAddBloc() : super(VisitPlanAddInitial());
  final VisitPlanRepo _visitPlanRepo = VisitPlanRepo();
  @override
  Stream<VisitPlanAddState> mapEventToState(
    VisitPlanAddEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is VisitPlanAddEventSave) {
      yield VisitPlanAddLoading();
      List<dynamic> result =
          await _visitPlanRepo.fetchAddVisitPlan(event.model);
      if (result[0] == true) {
        yield VisitPlanAddSuccess(succMsg: result[1].toString());
      } else {
        yield VisitPlanAddFailure(errMsg: result[1].toString());
      }
    }
  }
}

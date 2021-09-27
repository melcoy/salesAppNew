import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/general/reason_model.dart';
import 'package:sales_app/models/general/status_visit_plan_model.dart';

part 'visit_plan_pending_event.dart';
part 'visit_plan_pending_state.dart';

class VisitPlanPendingBloc
    extends Bloc<VisitPlanPendingEvent, VisitPlanPendingState> {
  VisitPlanPendingBloc() : super(VisitPlanPendingInitial());
  final VisitPlanRepo _visitPlanRepo = VisitPlanRepo();
  @override
  Stream<VisitPlanPendingState> mapEventToState(
    VisitPlanPendingEvent event,
  ) async* {
    if (event is VisitPlanPendingEventStarted) {
      yield VisitPlanPendingLoading();
      List<dynamic> resultStatus =
          await _visitPlanRepo.fetchGetStatusVisitPlan();
      List<dynamic> resultPending =
          await _visitPlanRepo.fetchPendingReasonVisitPlan();
      print("status" + resultStatus[1].toString());
      print("pending" + resultPending[1].toString());
      if (resultStatus[0] == true && resultPending[0] == true) {
        List<StatusVisitPlanModel> statusVP = resultStatus[1];
        List<ReasonModel> pendingReasonVP = resultPending[1];

        yield VisitPlanPendingLoaded(
            listStatusPending: statusVP, listReason: pendingReasonVP);
      } else {
        yield VisitPlanPendingFaillure(errMsg: "error");
      }
    }
  }
}

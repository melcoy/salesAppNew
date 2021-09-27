import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/visit_plan/list_visit_plan_model.dart';

part 'visit_plan_event.dart';
part 'visit_plan_state.dart';

class VisitPlanBloc extends Bloc<VisitPlanEvent, VisitPlanState> {
  VisitPlanBloc() : super(VisitPlanInitial());

  @override
  Stream<VisitPlanState> mapEventToState(
    VisitPlanEvent event,
  ) async* {
    VisitPlanRepo visitPlanRepo = VisitPlanRepo();

    if (event is VisitPlanEventDateSearch) {
      yield VisitPlanLoading();

      List<dynamic> result =
          await visitPlanRepo.fetchListVp(event.dateStart, event.dateEnd);

      if (result[0] == true) {
        List<ListVisitPlanModel> listVisitPlanModel = result[1];

        yield VisitPlanLoaded(listVisitPlanModel);
      } else {
        yield VisitPlanFailure(result[1].toString());
      }
    }
  }
}

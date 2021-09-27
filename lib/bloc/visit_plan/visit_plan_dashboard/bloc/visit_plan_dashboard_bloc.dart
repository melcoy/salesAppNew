import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/visit_plan/visit_plan_list_sales.dart';

part 'visit_plan_dashboard_event.dart';
part 'visit_plan_dashboard_state.dart';

class VisitPlanDashboardBloc
    extends Bloc<VisitPlanDashboardEvent, VisitPlanDashboardState> {
  VisitPlanDashboardBloc() : super(VisitPlanDashboardInitial());
  VisitPlanRepo _visitPlanRepo = VisitPlanRepo();
  @override
  Stream<VisitPlanDashboardState> mapEventToState(
    VisitPlanDashboardEvent event,
  ) async* {
    if (event is VisitPlanDashboardEventStarted) {
      yield VisitPlanDashboardLoading();
      List<VisitPlanListSales> listModel = [];
      List<dynamic> result =
          await _visitPlanRepo.fetchGetListSalesbyCust(event.idCustomer);
      if (result[0] == true) {
        listModel = result[1];
        listModel.sort((a, b) => b.tanggal.compareTo(a.tanggal));
        yield VisitPlanDashboardLoaded(model: listModel);
      } else {
        yield VisitPlanDashboardFailure(errMsg: "Data Fail");
      }
    }
  }
}

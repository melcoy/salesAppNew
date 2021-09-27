import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/dashboard/dashboard_repo.dart';
import 'package:sales_app/models/dashboard/dashboard_model.dart';
import 'package:sales_app/util/util.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  final DashboardRepo _dashboardRepo = DashboardRepo();
  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is DashboardEventStarted) {
      yield DashboardLoading();
      List<dynamic> result = await _dashboardRepo.fetchDashboardData(
          "${timeFormatPlus(0)} 00:00:00", "${timeFormatPlus(1)} 23:59:59");
      if (result[0] == true) {
        yield DashboardLoaded(result[1] as DashboardModel);
      } else {
        yield DashboardFailure(result[1].toString());
      }
    }
  }
}

part of 'visit_plan_dashboard_bloc.dart';

@immutable
abstract class VisitPlanDashboardEvent {}

class VisitPlanDashboardEventStarted extends VisitPlanDashboardEvent {
  final String idCustomer;

  VisitPlanDashboardEventStarted({required this.idCustomer});
}

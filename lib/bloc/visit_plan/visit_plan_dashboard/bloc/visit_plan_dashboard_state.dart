part of 'visit_plan_dashboard_bloc.dart';

@immutable
abstract class VisitPlanDashboardState {}

class VisitPlanDashboardInitial extends VisitPlanDashboardState {}

class VisitPlanDashboardLoading extends VisitPlanDashboardState {}

class VisitPlanDashboardFailure extends VisitPlanDashboardState {
  final String errMsg;
  VisitPlanDashboardFailure({required this.errMsg});
}

class VisitPlanDashboardLoaded extends VisitPlanDashboardState {
  final List<VisitPlanListSales> model;
  VisitPlanDashboardLoaded({required this.model});
}

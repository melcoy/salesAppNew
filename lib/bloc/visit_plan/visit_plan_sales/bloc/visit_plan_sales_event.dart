part of 'visit_plan_sales_bloc.dart';

@immutable
abstract class VisitPlanSalesEvent {}

class VisitPlanSalesEventSaved extends VisitPlanSalesEvent {
  final VisitPlanSavedDto model;

  VisitPlanSalesEventSaved({required this.model});
}

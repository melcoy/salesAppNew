part of 'visit_plan_add_bloc.dart';

@immutable
abstract class VisitPlanAddEvent {}

class VisitPlanAddEventSave extends VisitPlanAddEvent {
  final VisitPlanAddModel model;
  VisitPlanAddEventSave({required this.model});
}

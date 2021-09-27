part of 'visit_plan_bloc.dart';

@immutable
abstract class VisitPlanEvent {}

class VisitPlanEventDateSearch extends VisitPlanEvent {
  final String dateStart;
  final String dateEnd;

  VisitPlanEventDateSearch({required this.dateStart, required this.dateEnd});
}

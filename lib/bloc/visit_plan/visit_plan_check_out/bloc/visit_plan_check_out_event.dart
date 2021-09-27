part of 'visit_plan_check_out_bloc.dart';

@immutable
abstract class VisitPlanCheckOutEvent {}

class VisitPlanCheckOutPressed extends VisitPlanCheckOutEvent {
  final CheckInDto dto;
  VisitPlanCheckOutPressed(this.dto);
}

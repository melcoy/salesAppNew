part of 'visit_plan_check_in_bloc.dart';

@immutable
abstract class VisitPlanCheckInEvent {}

class VisitPlanCheckInEventCapture extends VisitPlanCheckInEvent {
  final String visitId;
  final String path;

  VisitPlanCheckInEventCapture({required this.visitId, required this.path});
}

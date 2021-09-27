part of 'visit_plan_pending_bloc.dart';

@immutable
abstract class VisitPlanPendingEvent {}

class VisitPlanPendingEventStarted extends VisitPlanPendingEvent {}

class VisitPlanPendingEventSavePressed extends VisitPlanPendingEvent {
  final String idStatusVP;
  final String idPendingReason;
  final String pendingNote;
  final String idVisitPlan;

  VisitPlanPendingEventSavePressed(
      {required this.idPendingReason,
      required this.idStatusVP,
      required this.pendingNote,
      required this.idVisitPlan});
}

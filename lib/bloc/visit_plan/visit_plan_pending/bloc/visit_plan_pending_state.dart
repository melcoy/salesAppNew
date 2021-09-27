part of 'visit_plan_pending_bloc.dart';

@immutable
abstract class VisitPlanPendingState {}

class VisitPlanPendingInitial extends VisitPlanPendingState {}

class VisitPlanPendingLoading extends VisitPlanPendingState {}

class VisitPlanPendingLoaded extends VisitPlanPendingState {
  final List<StatusVisitPlanModel> listStatusPending;
  final List<ReasonModel> listReason;
  VisitPlanPendingLoaded(
      {required this.listStatusPending, required this.listReason});
}

class VisitPlanPendingFaillure extends VisitPlanPendingState {
  final String errMsg;

  VisitPlanPendingFaillure({required this.errMsg});
}

class VisitPlanPendingSuccess extends VisitPlanPendingState {
  final String succMsg;

  VisitPlanPendingSuccess({required this.succMsg});
}

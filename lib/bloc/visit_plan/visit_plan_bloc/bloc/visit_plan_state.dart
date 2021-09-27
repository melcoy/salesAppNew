part of 'visit_plan_bloc.dart';

@immutable
abstract class VisitPlanState {}

class VisitPlanInitial extends VisitPlanState {}

class VisitPlanLoading extends VisitPlanState {}

class VisitPlanFailure extends VisitPlanState {
  final String errorMessage;

  VisitPlanFailure(this.errorMessage);
}

class VisitPlanLoaded extends VisitPlanState {
  final List<ListVisitPlanModel> listVisitPlanModel;

  VisitPlanLoaded(this.listVisitPlanModel);
}

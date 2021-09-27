part of 'visit_plan_add_bloc.dart';

@immutable
abstract class VisitPlanAddState {}

class VisitPlanAddInitial extends VisitPlanAddState {}

class VisitPlanAddLoading extends VisitPlanAddState {}

class VisitPlanAddFailure extends VisitPlanAddState {
  final String errMsg;
  VisitPlanAddFailure({required this.errMsg});
}

class VisitPlanAddSuccess extends VisitPlanAddState {
  final String succMsg;
  VisitPlanAddSuccess({required this.succMsg});
}

part of 'visit_plan_check_in_bloc.dart';

@immutable
abstract class VisitPlanCheckInState {}

class VisitPlanCheckInInitial extends VisitPlanCheckInState {}

class VisitPlanCheckInLoading extends VisitPlanCheckInState {}

class VisitPlanCheckInSuccess extends VisitPlanCheckInState {
  final String succMsg;

  VisitPlanCheckInSuccess({required this.succMsg});
}

class VisitPlanCheckInFaillure extends VisitPlanCheckInState {
  final String errMsg;

  VisitPlanCheckInFaillure({required this.errMsg});
}

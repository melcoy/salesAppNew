part of 'visit_plan_check_out_bloc.dart';

@immutable
abstract class VisitPlanCheckOutState {}

class VisitPlanCheckOutInitial extends VisitPlanCheckOutState {}

class VisitPlanCheckOutStateSuccess extends VisitPlanCheckOutState {}

class VisitPlanCheckOutStateLoading extends VisitPlanCheckOutState {}

class VisitPlanCheckOutStateFaillure extends VisitPlanCheckOutState {
  final String errMsg;
  VisitPlanCheckOutStateFaillure(this.errMsg);
}

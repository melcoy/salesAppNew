part of 'visit_plan_sales_bloc.dart';

@immutable
abstract class VisitPlanSalesState {}

class VisitPlanSalesInitial extends VisitPlanSalesState {}

class VisitPlanSalesLoading extends VisitPlanSalesState {}

class VisitPlanSalesFailure extends VisitPlanSalesState {
  final String errMsg;
  VisitPlanSalesFailure({required this.errMsg});
}

class VisitPlanSalesLoaded extends VisitPlanSalesState {
  final List<ListAllTruckModel> listAllProduct;
  VisitPlanSalesLoaded({required this.listAllProduct});
}

class VisitPlanSalesSaved extends VisitPlanSalesState {
  final String savedMsg;
  VisitPlanSalesSaved({required this.savedMsg});
}

part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardModel model;
  DashboardLoaded(this.model);
}

class DashboardFailure extends DashboardState {
  final String errMsg;

  DashboardFailure(this.errMsg);
}

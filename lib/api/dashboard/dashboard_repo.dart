import 'dashboard_provider.dart';

class DashboardRepo {
  final DashboardProvider _dashboardProvider = DashboardProvider();
  Future<List<dynamic>> fetchDashboardData(String dateStart, String dateEnd) =>
      _dashboardProvider.getDashboardData(dateStart, dateEnd);
}

import 'package:sales_app/api/visit_plan/visit_plan_provider.dart';
import 'package:sales_app/models/visit_plan/dto/visit_plan_saved_dto.dart';
import 'package:sales_app/models/visit_plan/visit_plan_add_model.dart';
import 'package:sales_app/models/visit_plan/visit_plan_check_in_model.dart';

class VisitPlanRepo {
  final VisitPlanProvider _visitPlanProvider = VisitPlanProvider();

  Future<List<dynamic>> fetchListVp(String dateStart, String dateEnd) =>
      _visitPlanProvider.getListVp(dateStart, dateEnd);

  Future<List<dynamic>> fetchAddVisitPlan(VisitPlanAddModel model) =>
      _visitPlanProvider.addVisitPlan(model);
  Future<List<dynamic>> fetchCheckInVisitPlan(
          VisitPlanCheckInModel model, String idVisitPlan) =>
      _visitPlanProvider.checkInVisitPlan(model, idVisitPlan);
  Future<bool> fetchAddSales(VisitPlanSavedDto model) =>
      _visitPlanProvider.addSales(model);
  Future<List<dynamic>> fetchGetListSalesbyCust(String idCustomer) =>
      _visitPlanProvider.getListSalesbyCust(idCustomer);
  Future<bool> fetchUpdateStatusVisitPlan(String status, String visitPlanId) =>
      _visitPlanProvider.updateStatusVisitPlan(status, visitPlanId);
  Future<bool> fetchCheckout(String long, String lat, String visitPlanId) =>
      _visitPlanProvider.checkout(long, lat, visitPlanId);

  Future<List<dynamic>> fetchGetStatusVisitPlan() =>
      _visitPlanProvider.getStatusVisitPlan();
  Future<List<dynamic>> fetchPendingReasonVisitPlan() =>
      _visitPlanProvider.getPendingReasonVisitPlan();
}

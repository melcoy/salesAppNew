import 'package:sales_app/models/customer/customer_add_model.dart';

import 'customer_provider.dart';

class CustomerRepo {
  final CustomerProvider _customerProvider = CustomerProvider();
  Future<List<dynamic>> fetchListCustomer() =>
      _customerProvider.getListCustomer();
  Future<bool> fetchAddCustomer(CustomerAddModel model) =>
      _customerProvider.addCustomer(model);
}

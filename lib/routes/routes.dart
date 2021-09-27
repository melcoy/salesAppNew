import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/auth/bloc/auth_bloc.dart';
import 'package:sales_app/bloc/customer/customer_add/bloc/customer_add_bloc.dart';
import 'package:sales_app/bloc/customer/list_customer/bloc/list_customer_bloc.dart';
import 'package:sales_app/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:sales_app/bloc/general/city/bloc/city_bloc.dart';
import 'package:sales_app/bloc/general/province/bloc/province_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_add/bloc/visit_plan_add_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_bloc/bloc/visit_plan_bloc.dart';
import 'package:sales_app/screen/auth/auth_screen.dart';
import 'package:sales_app/screen/customer/customer.dart';
import 'package:sales_app/screen/customer/customer_add.dart';
import 'package:sales_app/screen/customer/search_customer.dart';
import 'package:sales_app/screen/dashboard/dashboard.dart';
import 'package:sales_app/screen/general/city_screen.dart';
import 'package:sales_app/screen/general/province_screen.dart';
import 'package:sales_app/screen/visit_plan/visit_plan.dart';
import 'package:sales_app/screen/visit_plan/search_address_google.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_add.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_dashboard.dart';
import 'package:sales_app/shared/constant.dart';

Map<String, Widget Function(BuildContext)> routes =
    <String, Widget Function(BuildContext)>{
  loginRoute: (BuildContext context) => BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(),
        child: AuthScreen(),
      ),
  dashboardRoute: (BuildContext context) => BlocProvider(
        create: (context) => DashboardBloc(),
        child: const Dashboard(),
      ),
  visitPlanRoute: (BuildContext context) => BlocProvider(
        create: (context) => VisitPlanBloc(),
        child: const VisitPlan(),
      ),
  searchAdrressRoute: (BuildContext context) => const SearchAddressGoogle(),
  visitPlanAddRoute: (BuildContext context) => BlocProvider(
        create: (context) => VisitPlanAddBloc(),
        child: const VisitPlanAdd(),
      ),
  searchCustomerRoute: (BuildContext context) => BlocProvider(
        create: (context) => ListCustomerBloc(),
        child: SearchCustomer(),
      ),
  customerRoute: (BuildContext context) => BlocProvider(
        create: (context) => ListCustomerBloc(),
        child: Customer(),
      ),
  customerAddRoute: (BuildContext context) => BlocProvider(
        create: (context) => CustomerAddBloc(),
        child: CustomerAdd(),
      ),
  cityRoute: (BuildContext context) => BlocProvider(
        create: (context) => CityBloc(),
        child: CityScreen(),
      ),
  provinceRoute: (BuildContext context) => BlocProvider(
        create: (context) => ProvinceBloc(),
        child: ProvinceScreen(),
      ),
  cityRoute: (BuildContext context) => BlocProvider(
        create: (context) => CityBloc(),
        child: CityScreen(),
      ),
};

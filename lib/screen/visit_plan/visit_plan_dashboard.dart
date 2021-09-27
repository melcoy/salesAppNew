import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_dashboard/bloc/visit_plan_dashboard_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/screen/specification/search_truck.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_add_sales.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_tab/visit_plan_dashboard_tab_1.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_tab/visit_plan_dashboard_tab_2.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';

class VisitPlanDashboard extends StatefulWidget {
  final CheckInDto model;
  const VisitPlanDashboard({required this.model, Key? key}) : super(key: key);

  @override
  _VisitPlanDashboardState createState() =>
      _VisitPlanDashboardState(model: model);
}

class _VisitPlanDashboardState extends State<VisitPlanDashboard> {
  final CheckInDto model;
  _VisitPlanDashboardState({required this.model});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<VisitPlanDashboardBloc>(context).add(
      VisitPlanDashboardEventStarted(idCustomer: model.idCustomer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("Visit Plan"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, dashboardRoute);
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.note_add,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return VisitPlanAddSales(model: model);
                  }));
                })
          ],
        ),
        bottomNavigationBar: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.blockVertical * 1),
            child: Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: primaryColor,
                  tabs: <Widget>[
                    Container(
                      padding: EdgeInsets.all(SizeConfig.blockVertical * 0.5),
                      height: SizeConfig.blockVertical * 7,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.checklist_outlined,
                            color: primaryColor,
                          ),
                          Text(
                            "Visit Plan Check In",
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(SizeConfig.blockVertical * 0.5),
                      height: SizeConfig.blockVertical * 7,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.description_outlined,
                            color: primaryColor,
                          ),
                          Text(
                            "History Sales Customer",
                            style: TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
        body: BlocListener<VisitPlanDashboardBloc, VisitPlanDashboardState>(
          listener: (context, state) {
            if (state is VisitPlanDashboardLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LoadingDialog(message: "Please Wait");
                },
              );
            }
            if (state is VisitPlanDashboardLoaded) {
              Navigator.pop(context);
            }
            if (state is VisitPlanDashboardFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: Text(state.errMsg)));
            }
          },
          child: BlocBuilder<VisitPlanDashboardBloc, VisitPlanDashboardState>(
            builder: (context, state) {
              return TabBarView(children: <Widget>[
                VisitPlanDashboardTabSatu(model: model),
                if (state is VisitPlanDashboardLoaded)
                  VisitPlanDashboardTabDua(
                    model: state.model,
                  )
                else
                  Container()
              ]);
            },
          ),
        ),
      ),
    );
  }
}

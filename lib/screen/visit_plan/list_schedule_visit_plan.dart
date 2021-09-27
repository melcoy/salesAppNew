import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_check_in/bloc/visit_plan_check_in_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_dashboard/bloc/visit_plan_dashboard_bloc.dart';

import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/models/visit_plan/list_visit_plan_model.dart';
import 'package:sales_app/screen/visit_plan/shared/check_in_dialog_vp.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_dashboard.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/util/util.dart';

class ListScheduleVisitPlan extends StatefulWidget {
  final List<ListVisitPlanModel> model;
  const ListScheduleVisitPlan({required this.model, Key? key})
      : super(key: key);

  @override
  _ListScheduleVisitPlanState createState() =>
      _ListScheduleVisitPlanState(model);
}

class _ListScheduleVisitPlanState extends State<ListScheduleVisitPlan> {
  final List<ListVisitPlanModel>? model;
  _ListScheduleVisitPlanState(this.model);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Expanded(
      child: Column(
        children: <Widget>[
          if (model!.isNotEmpty)
            Flexible(
                child: ListView.builder(
                    itemCount: model!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        width: double.maxFinite,
                        child: Card(
                            elevation: 5,
                            child: ListTile(
                              // leading: Text(
                              //   "Task ${state.listTaskDto[index].project.prioritas}",
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .headline6!
                              //       .copyWith(
                              //           color: primaryColor,
                              //           fontSize: SizeConfig.blockVertical * 2,
                              //           fontWeight: FontWeight.bold),
                              // ),
                              title: Container(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  model![index].customer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: primaryColor,
                                          fontSize:
                                              SizeConfig.blockVertical * 1.5,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    width: SizeConfig.blockVertical * 30,
                                    child: Text(
                                      "Status Visit Plan: " +
                                          "${model![index].checkin.contains("10") ? "Undone " : "Done  "}",
                                      maxLines: 3,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.blockVertical * 1.5,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.blockVertical * 30,
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      "Adress: " + model![index].venue,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.blockVertical * 1.5,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: SizeConfig.blockVertical * 30,
                                    child: Text(
                                      "Tanggal: " +
                                          trimDate(
                                              model![index].tanggal.toString(),
                                              ".000"),
                                      maxLines: 3,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.blockVertical * 1.5,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                height: 30,
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: primaryColor,
                                ),
                              ),
                              onTap: () {
                                CheckInDto checkInDto = CheckInDto(
                                    idVisitPlan: model![index].id,
                                    address: model![index].venue,
                                    idCustomer: model![index].customerid,
                                    nama: model![index].customer);

                                if (model![index].checkin.contains("10")) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => BlocProvider(
                                            create: (context) =>
                                                VisitPlanCheckInBloc(),
                                            child: DialogCheckIn(
                                                model: checkInDto),
                                          ));
                                } else {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return BlocProvider(
                                      create: (context) =>
                                          VisitPlanDashboardBloc(),
                                      child: VisitPlanDashboard(
                                        model: checkInDto,
                                      ),
                                    );
                                  }));
                                }
                              },
                            )),
                      );
                    }))
          else
            Center(child: Container()),
        ],
      ),
    );
  }
}

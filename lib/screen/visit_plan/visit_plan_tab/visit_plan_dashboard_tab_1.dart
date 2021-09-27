import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_check_out/bloc/visit_plan_check_out_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_pending/bloc/visit_plan_pending_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/screen/visit_plan/shared/visit_plan_check_out_dialog.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_pending.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';

class VisitPlanDashboardTabSatu extends StatefulWidget {
  final CheckInDto model;
  const VisitPlanDashboardTabSatu({required this.model, Key? key})
      : super(key: key);

  @override
  _VisitPlanDashboardTabSatuState createState() =>
      _VisitPlanDashboardTabSatuState(model: model);
}

class _VisitPlanDashboardTabSatuState extends State<VisitPlanDashboardTabSatu> {
  final CheckInDto model;
  _VisitPlanDashboardTabSatuState({required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockVertical * 40,
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.blockVertical * 8,
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36))),
                child: Center(
                  child: Container(),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: SizeConfig.blockVertical * 5,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                        SizeConfig.blockHorizontal * 3,
                        SizeConfig.blockVertical * 3,
                        SizeConfig.blockHorizontal * 3,
                        SizeConfig.blockVertical * 3,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: primaryColor.withOpacity(0.23),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                                margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                child: const Icon(Icons.circle,
                                    color: primaryColor)),
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
                                model.nama,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: primaryColor,
                                        fontSize:
                                            SizeConfig.blockVertical * 2.5,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 5),
                                  width: SizeConfig.blockVertical * 30,
                                  child: Text(
                                    "Address: " + model.address,
                                    maxLines: 3,
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.blockVertical * 1.5,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalSpace(),
                          const VerticalSpace(),
                          FDButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider(
                                        create: (context) =>
                                            VisitPlanCheckOutBloc(),
                                        child: DialogCheckOut(model),
                                      ));
                            },
                            text: "Check Out",
                            textColor: Colors.white,
                          ),
                          const VerticalSpace(),
                          FDButton(
                            onPressed: () async {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return BlocProvider(
                                  create: (context) => VisitPlanPendingBloc(),
                                  child: VisitPlanPending(model: model),
                                );
                              }));
                            },
                            text: "Pending",
                            textColor: Colors.white,
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ],
    );
  }
}

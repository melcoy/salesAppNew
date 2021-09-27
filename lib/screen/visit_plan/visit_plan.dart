import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_bloc/bloc/visit_plan_bloc.dart';
import 'package:sales_app/screen/visit_plan/list_schedule_visit_plan.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_info_dialog.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';
import 'package:sales_app/shared/widget/fd_textfield_form_date.dart';
import 'package:sales_app/util/util.dart';

class VisitPlan extends StatefulWidget {
  const VisitPlan({Key? key}) : super(key: key);

  @override
  _VisitPlanState createState() => _VisitPlanState();
}

class _VisitPlanState extends State<VisitPlan> {
  final TextEditingController _dateStartController =
      TextEditingController(text: "");
  final TextEditingController _dateEndController =
      TextEditingController(text: "");

  @override
  void initState() {
    print("${timeFormatPlus(0)} 00:00:00");
    print("${timeFormatPlus(1)} 23:59:59");

    BlocProvider.of<VisitPlanBloc>(context).add(VisitPlanEventDateSearch(
        dateStart: "${timeFormatPlus(0)} 00:00:00",
        dateEnd: "${timeFormatPlus(1)} 23:59:59"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
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
                  Navigator.pushReplacementNamed(context, visitPlanAddRoute);
                })
          ],
        ),
        body: BlocListener<VisitPlanBloc, VisitPlanState>(
          listener: (context, state) {
            if (state is VisitPlanFailure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return InfoDialog(
                    message: state.errorMessage,
                  );
                },
              );
            }
          },
          child: BlocBuilder<VisitPlanBloc, VisitPlanState>(
            builder: (context, state) {
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
                                    FDTextFieldDateForm(
                                      controller: _dateStartController,
                                      prefixIcon: Icons.calendar_today_rounded,
                                      title: "Start Date",
                                    ),
                                    const VerticalSpace(),
                                    FDTextFieldDateForm(
                                      controller: _dateEndController,
                                      prefixIcon: Icons.calendar_today_rounded,
                                      title: "End Date",
                                    ),
                                    const VerticalSpace(),
                                    FDButton(
                                      onPressed: () async {
                                        if (DateFormat(
                                                    'EEEE, d MMM yyyy HH:mm:ss')
                                                .parse(_dateEndController.text +
                                                    " 23:59:59")
                                                .compareTo(DateFormat(
                                                        'EEEE, d MMM yyyy HH:mm')
                                                    .parse(_dateStartController
                                                            .text +
                                                        " 00:00:00")) <
                                            0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  duration:
                                                      Duration(seconds: 4),
                                                  content:
                                                      Text("Date Invalid")));
                                        } else {
                                          String dateEnd = DateFormat(
                                                  'EEEE, d MMM yyyy HH:mm:ss')
                                              .parse(_dateEndController.text +
                                                  " 23:59:59")
                                              .toString();
                                          String dateStart = DateFormat(
                                                  'EEEE, d MMM yyyy HH:mm')
                                              .parse(_dateStartController.text +
                                                  " 00:00:00")
                                              .toString();
                                          dateStart =
                                              trimDate(dateStart, ".000");
                                          dateEnd = trimDate(dateEnd, ".000");

                                          BlocProvider.of<VisitPlanBloc>(
                                                  context)
                                              .add(VisitPlanEventDateSearch(
                                                  dateStart: dateStart,
                                                  dateEnd: dateEnd));
                                        }
                                      },
                                      text: "Get Schedule",
                                      textColor: Colors.white,
                                    ),
                                  ],
                                )))
                      ],
                    ),
                  ),
                  if (state is VisitPlanLoading)
                    const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor)),
                    )
                  else if (state is VisitPlanLoaded)
                    ListScheduleVisitPlan(model: state.listVisitPlanModel)
                ],
              );
            },
          ),
        ));
  }
}

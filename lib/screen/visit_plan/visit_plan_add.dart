import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_add/bloc/visit_plan_add_bloc.dart';
import 'package:sales_app/models/visit_plan/visit_plan_add_model.dart';
import 'package:sales_app/screen/dashboard/dashboard.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';

import 'package:sales_app/shared/widget/fd_button.dart';

import 'package:sales_app/shared/widget/fd_spacer.dart';

import 'package:sales_app/shared/widget/fd_texfield_time.dart';
import 'package:sales_app/shared/widget/fd_textfield_form_date.dart';

import 'package:sales_app/util/util.dart';

class VisitPlanAdd extends StatefulWidget {
  const VisitPlanAdd({Key? key}) : super(key: key);

  @override
  _VisitPlanAddState createState() => _VisitPlanAddState();
}

class _VisitPlanAddState extends State<VisitPlanAdd> {
  final TextEditingController _dateController = TextEditingController(text: "");
  final TextEditingController _timeController = TextEditingController(text: "");
  String customerName = "";
  String addressField = "";
  String customerId = "";
  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: Theme.of(context).primaryColor,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Visit Plan Add"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
        child: BlocListener<VisitPlanAddBloc, VisitPlanAddState>(
          listener: (context, state) {
            if (state is VisitPlanAddFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: Text(state.errMsg.toString())));
            }
            if (state is VisitPlanAddSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(state.succMsg.toString())));
              Navigator.pushReplacementNamed(context, visitPlanRoute);
            }
          },
          child: BlocBuilder<VisitPlanAddBloc, VisitPlanAddState>(
            builder: (context, state) {
              return ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                children: <Widget>[
                  const VerticalSpace(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          String? address = await Navigator.pushNamed<dynamic>(
                              context, searchAdrressRoute) as String;
                          if (address != null) {
                            addressField = address;
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 120,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              left: borderSide,
                              top: borderSide,
                              right: borderSide,
                              bottom: borderSide,
                            ),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.search),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Tap To Search Address")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpace(),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Text(
                          "Meeting Point",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockVertical * 2,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: SizeConfig.blockVertical * 4,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: addressField == ""
                            ? Text(
                                "Empty Address",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: primaryColor,
                                        fontSize:
                                            SizeConfig.blockVertical * 1.5,
                                        fontWeight: FontWeight.bold),
                              )
                            : Text(
                                addressField,
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
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          const VerticalSpace(),
                          FDTextFieldDateForm(
                            controller: _dateController,
                            prefixIcon: Icons.calendar_today_rounded,
                            title: "Date Meeting",
                          ),
                          const VerticalSpace(),
                          FDTextFieldTime(
                            controller: _timeController,
                            prefixIcon: Icons.access_time,
                            title: "Time Meeting",
                          ),
                          const VerticalSpace(),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpace(),
                  Card(
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () async {
                        var data = await Navigator.pushNamed(
                            context, searchCustomerRoute);

                        if (data != null) {
                          var data2 = data as List<dynamic>;
                          customerName = data2[1];
                          customerId = data2[0].toString();
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            const VerticalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockHorizontal * 3),
                                  child: Text(
                                    "Customer",
                                    style: TextStyle(
                                        fontSize: SizeConfig.blockVertical * 2,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockHorizontal * 3),
                                        child: const Icon(Icons.person)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    customerName == ""
                                        ? Text(
                                            "Tap to Choose Customer",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: primaryColor,
                                                    fontSize: SizeConfig
                                                            .blockVertical *
                                                        2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        : Text(
                                            customerName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: primaryColor,
                                                    fontSize: SizeConfig
                                                            .blockVertical *
                                                        2,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                  ],
                                )
                              ],
                            ),
                            const VerticalSpace(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpace(),
                  if (state is VisitPlanAddLoading)
                    const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor)),
                    )
                  else
                    FDButton(
                      text: "Add Plan",
                      textColor: Colors.white,
                      onPressed: () {
                        if (customerName != "") {
                          String dateStart = DateFormat('EEEE, d MMM yyyy')
                              .parse(_dateController.text + " 00:00:00")
                              .toString();

                          dateStart = trimDate(dateStart, "00:00:00.000");

                          String timeString =
                              dateStart + _timeController.text + ":00";
                          VisitPlanAddModel model = VisitPlanAddModel(
                              tanggal: timeString,
                              customer: customerId,
                              venue: addressField);
                          BlocProvider.of<VisitPlanAddBloc>(context)
                              .add(VisitPlanAddEventSave(model: model));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please input some data')));
                        }
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

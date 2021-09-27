import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_dashboard/bloc/visit_plan_dashboard_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_sales/bloc/visit_plan_sales_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/models/visit_plan/dto/visit_plan_saved_dto.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_dashboard.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';

import '../visit_plan_add_sales.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

class VPSalesConfirmDialog extends StatelessWidget {
  final CheckInDto model;
  double total = 0;
  String qty = "";
  String bonusAdded = "";
  String product = "";
  String discount = "";
  String bonus = "";
  String tipeBayar = "";
  String visitPlanId = "";
  String id = "";
  String textBayar = "";

  VPSalesConfirmDialog(
      {required this.model,
      required this.bonus,
      required this.bonusAdded,
      required this.product,
      required this.discount,
      required this.total,
      required this.qty,
      required this.tipeBayar,
      required this.visitPlanId,
      required this.id,
      required this.textBayar});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BlocListener<VisitPlanSalesBloc, VisitPlanSalesState>(
        listener: (context, state) {
          if (state is VisitPlanSalesSaved) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 4),
                content: Text(state.savedMsg.toString())));
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => VisitPlanDashboardBloc(),
                child: VisitPlanDashboard(model: model),
              );
            }));
          }
          if (state is VisitPlanSalesFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 4),
                content: Text(state.errMsg)));
          }
        },
        child: BlocBuilder<VisitPlanSalesBloc, VisitPlanSalesState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0))
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Confirm Sales",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                      child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              product,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    const VerticalSpace(),
                    Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Discount : " + discount + "%",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                    const VerticalSpace(),
                    Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Bonus : " + bonus,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                    const VerticalSpace(),
                    Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Qty : " + qty,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                    const VerticalSpace(),
                    Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Payment Type : " + textBayar,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                    const VerticalSpace(),
                    SizedBox(
                      height: 75,
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Bonus Added : " + bonusAdded,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const VerticalSpace(),
                    Container(
                      height: 30,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            // "Total Price : ${formatCurrency.format(double.tryParse((total * double.parse(qty)).toStringAsFixed(0)))}"
                            "Total : ${formatCurrency.format(double.parse((total * double.parse(qty)).toStringAsFixed(0)))}"
                            // "Total Price : ${(total * double.parse(qty)).toStringAsFixed(0)}"
                            ,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          )),
                    ),
                    const VerticalSpace(),
                    if (state is VisitPlanSalesLoading)
                      const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor)),
                      )
                    else
                      FDButton(
                        onPressed: () async {
                          VisitPlanSavedDto model = VisitPlanSavedDto(
                              bonustambahan: bonusAdded,
                              discount: discount,
                              hargaterjual: (total * double.parse(qty))
                                  .toStringAsFixed(0),
                              idProduk: id,
                              quantity: qty,
                              tipebayar: tipeBayar,
                              visitplan: visitPlanId);
                          BlocProvider.of<VisitPlanSalesBloc>(context).add(
                            VisitPlanSalesEventSaved(model: model),
                          );
                        },
                        text: "Confirm Sales",
                        textColor: Colors.white,
                      ),
                    const VerticalSpace(),
                    FDButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: "Cancel",
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

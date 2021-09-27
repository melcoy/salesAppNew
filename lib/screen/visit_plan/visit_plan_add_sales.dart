import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sales_app/bloc/spesification/search/list_truck_search/bloc/list_truck_search_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_sales/bloc/visit_plan_sales_bloc.dart';
import 'package:sales_app/models/spesification/dto/list_truck_dto.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/screen/specification/search_truck.dart';
import 'package:sales_app/screen/visit_plan/shared/visit_plan_sales_confirm_dialog.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';
import 'package:sales_app/shared/widget/fd_square_texfield.dart';

class VisitPlanAddSales extends StatefulWidget {
  final CheckInDto model;
  const VisitPlanAddSales({required this.model, Key? key}) : super(key: key);

  @override
  _VisitPlanAddSalesState createState() =>
      _VisitPlanAddSalesState(model: model);
}

class _VisitPlanAddSalesState extends State<VisitPlanAddSales> {
  final CheckInDto model;

  _VisitPlanAddSalesState({required this.model});
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  TextEditingController qtyController = TextEditingController();
  TextEditingController bonusAddController = TextEditingController();
  bool value = false;
  bool tunaiValue = false;
  bool kreditValue = false;
  bool plusAdd = false;
  double total = 0;
  double qty = 1;
  String percent = "100.0";
  String val = "";
  String truckChoose = "";
  String chooseProduct = "Choose Product";
  String discount = "";
  String bonus = "";
  String idProduct = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            children: <Widget>[
              const VerticalSpace(),
              Card(
                elevation: 5,
                child: GestureDetector(
                  onTap: () async {
                    ListTruckDto? model = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => ListTruckSearchBloc(),
                        child: SearchTruck(),
                      );
                    }));

                    if (model != null) {
                      setState(() {
                        idProduct = model.id;
                        chooseProduct = model.type;
                        discount =
                            (double.parse(model.discount) * 100).toString();
                        total = double.parse(model.harga) -
                            double.parse(model.harga) *
                                double.parse(model.discount);

                        for (int i = 0; i < model.bonus.length; i++) {
                          bonus += model.bonus[i] + " ";
                        }
                        plusAdd = true;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Product",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        const VerticalSpace(),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockHorizontal * 3),
                                child: const Icon(Icons.local_shipping_sharp)),
                            SizedBox(
                              width: SizeConfig.blockVertical * 2,
                            ),
                            chooseProduct == "Choose Product"
                                ? Text(
                                    "Tap to Choose Product",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize:
                                                SizeConfig.blockVertical * 2,
                                            fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    chooseProduct,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize:
                                                SizeConfig.blockVertical * 1.7,
                                            fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                        const VerticalSpace(),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Discount",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        const VerticalSpace(),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockHorizontal * 3),
                                child: const Icon(Icons.sell)),
                            SizedBox(
                              width: SizeConfig.blockVertical * 2,
                            ),
                            Text(
                              "Discount : " + discount + "%",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: primaryColor,
                                      fontSize: SizeConfig.blockVertical * 1.7,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const VerticalSpace(),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Bonus",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        const VerticalSpace(),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockHorizontal * 3),
                                child: const Icon(Icons.playlist_add_rounded)),
                            SizedBox(
                              width: SizeConfig.blockVertical * 2,
                            ),
                            bonus == ""
                                ? Text(
                                    "No Bonus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize:
                                                SizeConfig.blockVertical * 2,
                                            fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    bonus,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            color: primaryColor,
                                            fontSize:
                                                SizeConfig.blockVertical * 1.7,
                                            fontWeight: FontWeight.bold),
                                  ),
                          ],
                        ),
                        const VerticalSpace(),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Price",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        const VerticalSpace(),
                        Row(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockHorizontal * 3),
                                child: const Icon(Icons.sell)),
                            SizedBox(
                              width: SizeConfig.blockVertical * 2,
                            ),
                            Text(
                              "Price : ${formatCurrency.format(double.parse(total.toStringAsFixed(0)))}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: primaryColor,
                                      fontSize: SizeConfig.blockVertical * 1.7,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const VerticalSpace(),
              Card(
                elevation: 5,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: primaryColor,
                              value: tunaiValue,
                              onChanged: (value) {
                                tunaiValue = !tunaiValue;
                                if (tunaiValue == true) {
                                  kreditValue = false;
                                }
                                setState(() {});
                              },
                            ),
                            Text(
                              'Cash',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
                              child: Checkbox(
                                value: kreditValue,
                                onChanged: (value) {
                                  kreditValue = !kreditValue;
                                  if (kreditValue == true) {
                                    tunaiValue = false;
                                  }
                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              'Credit',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockHorizontal * 3),
                          child: Text(
                            "Qty",
                            style: TextStyle(
                                fontSize: SizeConfig.blockVertical * 2,
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  qty -= 1;
                                  print('qty min');
                                  print(qty *
                                      double.parse(total.toStringAsFixed(0)));
                                });
                              },
                              icon: Icon(Icons.remove_circle_sharp),
                              color: primaryColor,
                            ),
                            Container(
                              width: 80,
                              height: 40,
                              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: TextFormField(
                                controller: qtyController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onEditingComplete: () {},
                                maxLines: 5,
                                validator: (value) {
                                  if (qty.toStringAsFixed(0).toString() ==
                                          null ||
                                      qty
                                          .toStringAsFixed(0)
                                          .toString()
                                          .isEmpty) {
                                    return 'Enter Qty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: qty.toStringAsFixed(0).toString(),
                                  labelStyle: TextStyle(
                                      fontSize: SizeConfig.blockVertical * 2.5),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  qty += 1;
                                  print('qty add');
                                  print(qty *
                                      double.parse(total.toStringAsFixed(0)));
                                });
                              },
                              icon: Icon(Icons.add_circle),
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              const VerticalSpace(),
              FDSquareTextfield(
                readOnly: false,
                label: const Text(
                  "Bonus",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                maxLine: 5,
                controller: bonusAddController,
                typeKeyboard: false,
              ),
              const VerticalSpace(),
              FDButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (!chooseProduct.contains("Choose Product")) {
                      String tipeBayar = "";
                      String textBayar = "";

                      if (kreditValue == false && tunaiValue == false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 4),
                            content: Text("Please Input Type Payment")));
                      } else {
                        if (kreditValue == true) {
                          tipeBayar = "20";
                          textBayar = "Kredit";
                        } else if (tunaiValue == true) {
                          tipeBayar = "10";
                          textBayar = "Cash";
                        }
                        print(tipeBayar);
                        showDialog(
                            context: context,
                            builder: (context) =>
                                BlocProvider<VisitPlanSalesBloc>(
                                  create: (context) => VisitPlanSalesBloc(),
                                  child: VPSalesConfirmDialog(
                                    model: model,
                                    bonus: bonus,
                                    bonusAdded: bonusAddController.text,
                                    discount: discount,
                                    product: chooseProduct,
                                    qty: qty.toStringAsFixed(0).toString(),
                                    total: total,
                                    tipeBayar: tipeBayar,
                                    visitPlanId: model.idVisitPlan,
                                    id: idProduct,
                                    textBayar: textBayar,
                                  ),
                                ));
                      }
                    }
                  }
                },
                text: "Add Sales",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

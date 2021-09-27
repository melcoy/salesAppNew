import 'package:flutter/material.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/models/visit_plan/visit_plan_list_sales.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';

class VisitPlanDashboardTabDua extends StatefulWidget {
  final List<VisitPlanListSales> model;
  const VisitPlanDashboardTabDua({required this.model, Key? key})
      : super(key: key);

  @override
  _VisitPlanDashboardTabDuaState createState() =>
      _VisitPlanDashboardTabDuaState(model: model);
}

class _VisitPlanDashboardTabDuaState extends State<VisitPlanDashboardTabDua> {
  final List<VisitPlanListSales> model;
  _VisitPlanDashboardTabDuaState({required this.model});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (_, index) {
        return Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: Card(
              elevation: 5,
              child: ListTile(
                title: SizedBox(
                  height: 75,
                  child: Container(
                    height: 30,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      model[index].produk,
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Closing: " + model[index].raihan,
                      maxLines: 3,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                    const VerticalSpace(),
                    Text(
                      "Qty: " + model[index].quantity,
                      maxLines: 3,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                    const VerticalSpace(),
                    Text(
                      "Date: " + model[index].tanggal,
                      maxLines: 3,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.black38, fontWeight: FontWeight.bold),
                    ),
                    const VerticalSpace(),
                  ],
                ),
                trailing: Container(
                  height: 30,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: primaryColor,
                  ),
                ),
                onTap: () {
                  // (imageFile!= null)? showDialog(
                  //     context: context,
                  //     builder: (context) => DialogCheckIn()) : SizedBox();
                },
              )),
        );
      },
    );
  }
}

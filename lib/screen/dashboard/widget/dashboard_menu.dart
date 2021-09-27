import 'package:flutter/material.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/util/util.dart';

class MenuDashboard extends StatelessWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyMenu(
              title: "Visit Plan",
              icon: Icons.assignment,
              destination: visitPlanRoute,
            ),
            MyMenu(
              title: "Customer",
              icon: Icons.supervised_user_circle,
              destination: customerRoute,
            ),
            MyMenu(
              title: "Spec & Price",
              icon: Icons.local_shipping,
              destination: '/ListTruck',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyMenu(
              title: "Report Sales",
              icon: Icons.assignment_ind,
              destination: '/ReportSales',
            ),
            MyMenu(title: "Promo & Disc", icon: Icons.contact_support_rounded),
            MyMenu(title: "About", icon: Icons.miscellaneous_services_rounded),
          ],
        ),
      ],
    ));
  }
}

class MyMenu extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? destination;

  MyMenu({Key? key, required this.title, required this.icon, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(SizeConfig.blockVertical * 1.5),
            width: SizeConfig.blockHorizontal * 25,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: accentColor,
              child: InkWell(
                onTap: () async {
                  final bool resultloc = await getPermissionLocation();
                  if (resultloc) {
                    Navigator.pushNamed(context, destination!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 4),
                        content: Text("Please Allow First")));
                  }
                },
                child: Center(
                  child: Container(
                    height: SizeConfig.blockVertical * 11,
                    child: Icon(
                      icon,
                      size: SizeConfig.blockVertical * 7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockVertical * 1.8,
                ),
          )
        ],
      ),
    );
  }
}

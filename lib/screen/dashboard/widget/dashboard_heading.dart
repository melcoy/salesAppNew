import 'package:flutter/material.dart';
import 'package:sales_app/models/dashboard/dashboard_model.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';

class DashboardHeading extends StatefulWidget {
  final DashboardModel? model;
  const DashboardHeading({this.model, Key? key}) : super(key: key);

  @override
  _DashboardHeadingState createState() => _DashboardHeadingState(model);
}

class _DashboardHeadingState extends State<DashboardHeading> {
  final DashboardModel? model;
  _DashboardHeadingState(this.model);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: <Widget>[
        SizedBox(
          height: SizeConfig.blockVertical * 25,
          child: Stack(
            children: <Widget>[
              Container(
                height: SizeConfig.blockVertical * 15,
                decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36))),
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Total Sales",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        if (model != null)
                          Text(
                            "Rp. " + model!.salesLocale,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        else
                          const Text(
                            "Rp.0",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: SizeConfig.blockVertical * 12.5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      SizeConfig.blockHorizontal * 2,
                      SizeConfig.blockVertical * 2,
                      SizeConfig.blockHorizontal * 2,
                      SizeConfig.blockVertical * 2,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: SizeConfig.blockVertical * 11,
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
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Target: ",
                                style: TextStyle(
                                    fontSize: SizeConfig.blockVertical * 2,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (model != null)
                                Text(
                                  "Rp " + model!.targetPencapaianLocale,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.blockVertical * 1.5,
                                      ),
                                )
                              else
                                Text(
                                  "Rp.0",
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockVertical * 1.5,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                )
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          color: Colors.red,
                          width: 20,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Target Visit: ",
                                style: TextStyle(
                                    fontSize: SizeConfig.blockVertical * 2,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (model != null)
                                Text(
                                  model!.targetKunjungan,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.blockVertical * 2,
                                      ),
                                )
                              else
                                Center(
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockVertical * 1.5,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}

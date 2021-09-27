import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_check_out/bloc/visit_plan_check_out_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_dashboard/bloc/visit_plan_dashboard_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/screen/dashboard/dashboard.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_dashboard.dart';
import 'package:sales_app/shared/theme.dart';

class DialogCheckOut extends StatefulWidget {
  final CheckInDto model;
  DialogCheckOut(this.model);
  @override
  _DialogCheckOutState createState() => _DialogCheckOutState(model);
}

class _DialogCheckOutState extends State<DialogCheckOut> {
  //File imageFile;
  final CheckInDto model;
  _DialogCheckOutState(this.model);
  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitPlanCheckOutBloc, VisitPlanCheckOutState>(
      listener: (context, state) {
        if (state is VisitPlanCheckOutStateFaillure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 4),
              content: Text(state.errMsg)));
        }
        if (state is VisitPlanCheckOutStateSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => VisitPlanDashboardBloc(),
              child: BlocProvider(
                create: (context) => DashboardBloc(),
                child: Dashboard(),
              ),
            );
          }));
        }
      },
      child: BlocBuilder<VisitPlanCheckOutBloc, VisitPlanCheckOutState>(
        builder: (context, state) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      const Text(
                        "After check out you cannot change your status. Are you sure?",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      if (state is VisitPlanCheckOutStateLoading)
                        const Center(
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor)),
                        )
                      else
                        ElevatedButton(
                          child: const Text(
                            "Check Out",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                            onPrimary: Colors.white,
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            shape: const BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                          onPressed: () async {
                            BlocProvider.of<VisitPlanCheckOutBloc>(context)
                                .add(VisitPlanCheckOutPressed(model));
                          },
                        ),
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

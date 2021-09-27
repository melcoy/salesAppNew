import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/dashboard/bloc/dashboard_bloc.dart';
import 'package:sales_app/screen/dashboard/widget/dashboard_heading.dart';
import 'package:sales_app/screen/dashboard/widget/dashboard_menu.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';
import 'package:sales_app/util/util.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(
      DashboardEventStarted(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is DashboardFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: Text(state.errMsg)));
            }
            if (state is DashboardLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LoadingDialog(message: "Please Wait");
                },
              );
            }
            if (state is DashboardLoaded) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is DashboardLoaded)
                      DashboardHeading(model: state.model),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            dateFormat(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    MenuDashboard(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_check_in/bloc/visit_plan_check_in_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';
import 'package:sales_app/screen/visit_plan/shared/camera_upload_screen.dart';
import 'package:sales_app/util/util.dart';

class DialogCheckIn extends StatefulWidget {
  final CheckInDto model;
  const DialogCheckIn({Key? key, required this.model}) : super(key: key);
  @override
  _DialogCheckInState createState() => _DialogCheckInState(model);
}

class _DialogCheckInState extends State<DialogCheckIn> {
  //File imageFile;

  CheckInDto model;

  _DialogCheckInState(this.model);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 16, left: 16, right: 16),
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
                const VerticalSpace(),
                const Text(
                  "Check In",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  "Before Check-In, Make sure you properly meet the prospect !",
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                FDButton(
                  onPressed: () async {
                    final bool result = await getPermissionCamera();
                    if (result) {
                      CameraController controller;
                      var cameras = await availableCameras();
                      controller =
                          CameraController(cameras[0], ResolutionPreset.medium);
                      String imagePath = (await Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                        create: (context) =>
                                            VisitPlanCheckInBloc(),
                                        child: CameraUploadScreen(
                                            controller, model),
                                      )))) ??
                          "";

                      controller.dispose();
                    }
                  },
                  text: "Check In",
                  textColor: Colors.white,
                ),
                // ElevatedButton(
                //   child: const Text(
                //     "Check In",
                //     style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: primaryColor,
                //     onPrimary: Colors.white,
                //     minimumSize: Size(MediaQuery.of(context).size.width, 50),
                //     shape: const BeveledRectangleBorder(
                //         borderRadius: BorderRadius.all(Radius.circular(5))),
                //   ),
                //   onPressed: () async {
                //     // imageFile = await Navigator.push<File>(context,
                //     //     MaterialPageRoute(builder: (_) => Camera2PageState()));
                //     // setState(() {});
                //     // Navigator.pushReplacement(
                //     //     context,
                //     //     MaterialPageRoute(
                //     //         builder: (context) =>
                //     //             BlocProvider<VisitplancheckinblocBloc>(
                //     //                 create: (BuildContext context) =>
                //     //                     VisitplancheckinblocBloc(),
                //     //                 child: CameraPageState(
                //     //                   model: model,
                //     //                 ))));
                //   },
                // ),
                TextButton(
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: primaryColor, fontWeight: FontWeight.bold),
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
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_check_in/bloc/visit_plan_check_in_bloc.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_dashboard/bloc/visit_plan_dashboard_bloc.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/screen/visit_plan/visit_plan_dashboard.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';

class CameraUploadScreen extends StatefulWidget {
  final CameraController controller;
  final CheckInDto model;
  const CameraUploadScreen(this.controller, this.model);

  @override
  _CameraUploadScreenState createState() =>
      _CameraUploadScreenState(controller, model);
}

class _CameraUploadScreenState extends State<CameraUploadScreen> {
  CameraController controller;
  final CheckInDto model;
  _CameraUploadScreenState(this.controller, this.model);
  Future<void> initializeCamera() async {
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/ImageCheck-In';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/${DateTime.now()}.jpg';

    try {
      await controller.takePicture(filePath);
    } catch (e) {
      return "";
    }

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        // Navigator.of(context).pushNamed(listTaskRoute);
        return false;
      },
      child: BlocListener<VisitPlanCheckInBloc, VisitPlanCheckInState>(
        listener: (context, state) {
          if (state is VisitPlanCheckInFaillure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 4),
                content: Text(state.errMsg)));
            Navigator.pop(context);
          }
          if (state is VisitPlanCheckInLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const LoadingDialog(message: "Please Wait");
              },
            );
          }
          if (state is VisitPlanCheckInSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 4),
                content: Text(state.succMsg.toString())));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) => VisitPlanDashboardBloc(),
                child: VisitPlanDashboard(
                  model: model,
                ),
              );
            }));
          }
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
                future: initializeCamera(),
                builder: (_, snapshot) =>
                    (snapshot.connectionState == ConnectionState.done)
                        ? Stack(children: <Widget>[
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height -
                                      100 / controller.value.aspectRatio,
                                  child: CameraPreview(controller),
                                ),
                                Container(
                                  width: SizeConfig.blockHorizontal * 25,
                                  height: SizeConfig.blockVertical * 10,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockHorizontal * 1.5),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: primaryColor,
                                      size: 80,
                                    ),
                                    onPressed: () async {
                                      if (!controller.value.isTakingPicture!) {
                                        String path = await takePicture();
                                        controller.dispose();
                                        BlocProvider.of<VisitPlanCheckInBloc>(
                                                context)
                                            .add(
                                          VisitPlanCheckInEventCapture(
                                              path: path,
                                              visitId: model.idVisitPlan),
                                        );
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ])
                        : const Center(
                            child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )))),
      ),
    );
  }
}

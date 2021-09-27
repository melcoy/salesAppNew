import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales_app/api/visit_plan/visit_plan_repo.dart';
import 'package:sales_app/models/visit_plan/visit_plan_check_in_model.dart';
import 'package:sales_app/util/cloudinary_upload.dart';
import 'package:sales_app/util/get_location.dart';

part 'visit_plan_check_in_event.dart';
part 'visit_plan_check_in_state.dart';

class VisitPlanCheckInBloc
    extends Bloc<VisitPlanCheckInEvent, VisitPlanCheckInState> {
  VisitPlanCheckInBloc() : super(VisitPlanCheckInInitial());
  final CloudinaryUpload _cloudinaryUpload = CloudinaryUpload();
  final VisitPlanRepo _visitPlanRepo = VisitPlanRepo();

  final GetLocation _getLocation = GetLocation();
  @override
  Stream<VisitPlanCheckInState> mapEventToState(
    VisitPlanCheckInEvent event,
  ) async* {
    if (event is VisitPlanCheckInEventCapture) {
      yield VisitPlanCheckInLoading();
      var loc = await _getLocation.getLocation();
      String url = await _cloudinaryUpload.uploadToCloudinary(event.path);

      if (loc.isNotEmpty && url.isNotEmpty) {
        VisitPlanCheckInModel model = VisitPlanCheckInModel(
            photo: url, latitude: loc[0], longitude: loc[1]);

        List<dynamic> result =
            await _visitPlanRepo.fetchCheckInVisitPlan(model, event.visitId);
        if (result[0] == true) {
          yield VisitPlanCheckInSuccess(succMsg: result[1].toString());
        } else {
          yield VisitPlanCheckInFaillure(errMsg: result[1].toString());
        }
      }
    }
    // TODO: implement mapEventToState
  }
}

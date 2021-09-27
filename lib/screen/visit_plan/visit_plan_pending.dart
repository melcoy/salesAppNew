import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sales_app/bloc/visit_plan/visit_plan_pending/bloc/visit_plan_pending_bloc.dart';
import 'package:sales_app/models/general/reason_model.dart';
import 'package:sales_app/models/general/status_visit_plan_model.dart';
import 'package:sales_app/models/visit_plan/check_in_dto.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';
import 'package:sales_app/shared/widget/fd_square_texfield.dart';
import 'package:substring_highlight/substring_highlight.dart';

class VisitPlanPending extends StatefulWidget {
  final CheckInDto model;
  const VisitPlanPending({Key? key, required this.model}) : super(key: key);

  @override
  _VisitPlanPendingState createState() => _VisitPlanPendingState(model: model);
}

class _VisitPlanPendingState extends State<VisitPlanPending> {
  final CheckInDto model;
  _VisitPlanPendingState({required this.model});
  TextEditingController controllerStatus = TextEditingController();
  TextEditingController controllerReason = TextEditingController();
  TextEditingController controllerReasonBox = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<VisitPlanPendingBloc>(context)
        .add(VisitPlanPendingEventStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Visit Plan Pending"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
          child: BlocListener<VisitPlanPendingBloc, VisitPlanPendingState>(
        listener: (context, state) {
          if (state is VisitPlanPendingLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return const LoadingDialog(message: "Please Wait");
              },
            );
          }
          if (state is VisitPlanPendingLoaded) {
            Navigator.pop(context);
          }
          if (state is VisitPlanPendingFaillure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 4),
                content: Text(state.errMsg)));
          }
        },
        child: BlocBuilder<VisitPlanPendingBloc, VisitPlanPendingState>(
          builder: (context, state) {
            if (state is VisitPlanPendingLoaded) {
              return SingleChildScrollView(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Text(
                                  "Pending & Reason",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.blockVertical * 2,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              VerticalSpace(),
                              TypeAheadField<StatusVisitPlanModel>(
                                hideSuggestionsOnKeyboardHide: false,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: controllerStatus,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    hintText: "Search Status Pending",
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  if (pattern.isEmpty) {
                                    return const Iterable<
                                        StatusVisitPlanModel>.empty();
                                  } else {
                                    return state.listStatusPending.where(
                                        (word) => word.name
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase()));
                                  }
                                },
                                itemBuilder: (context, suggestion) {
                                  final jenis = suggestion;

                                  return ListTile(
                                    title: SubstringHighlight(
                                      text: jenis.name,
                                      term: controllerStatus.text,
                                      textStyleHighlight: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text("ID : ${jenis.id}"),
                                  );
                                },
                                noItemsFoundBuilder: (context) => Container(
                                  height: SizeConfig.blockVertical * 5,
                                  child: const Center(
                                    child: Text(
                                      'Kendala Not Found.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                onSuggestionSelected: (suggestion) {
                                  final jenis = suggestion;

                                  controllerStatus.text = jenis.name;
                                },
                              ),
                              VerticalSpace(),
                              VerticalSpace(),
                              TypeAheadField<ReasonModel>(
                                hideSuggestionsOnKeyboardHide: false,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: controllerReason,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    hintText: "Search Reason",
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  if (pattern.isEmpty) {
                                    return const Iterable<ReasonModel>.empty();
                                  } else {
                                    return state.listReason.where((word) => word
                                        .name
                                        .toLowerCase()
                                        .contains(pattern.toLowerCase()));
                                  }
                                },
                                itemBuilder: (context, suggestion) {
                                  final jenis = suggestion;

                                  return ListTile(
                                    title: SubstringHighlight(
                                      text: jenis.name,
                                      term: controllerReason.text,
                                      textStyleHighlight: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    subtitle: Text("ID : ${jenis.id}"),
                                  );
                                },
                                noItemsFoundBuilder: (context) => Container(
                                  height: SizeConfig.blockVertical * 5,
                                  child: const Center(
                                    child: Text(
                                      'Kendala Not Found.',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                                onSuggestionSelected: (suggestion) {
                                  final jenis = suggestion;

                                  controllerReason.text = jenis.name;
                                },
                              ),
                              VerticalSpace(),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpace(),
                      FDSquareTextfield(
                        readOnly: false,
                        label: const Text(
                          "Additional Reason",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        maxLine: 5,
                        controller: controllerReasonBox,
                        typeKeyboard: false,
                      ),
                      VerticalSpace(),
                      FDButton(
                        onPressed: () async {
                          // if (_formKey.currentState!.validate()) {
                          //   _emailController.text = "james@gmail.com";
                          //   _passwordController.text = "a";
                          //   BlocProvider.of<AuthBloc>(context).add(
                          //     LoginButtonPressed(
                          //         email: _emailController.text,
                          //         password: _passwordController.text),
                          //   );
                          // }
                        },
                        text: "Add Reason",
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      )),
    );
  }
}

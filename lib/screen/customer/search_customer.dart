import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/customer/list_customer/bloc/list_customer_bloc.dart';
import 'package:sales_app/models/customer/list_customer_model.dart';
import 'package:sales_app/shared/size_config.dart';

import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';

class SearchCustomer extends StatefulWidget {
  const SearchCustomer({Key? key}) : super(key: key);

  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListCustomerBloc>(context).add(ListCustomerEventStarted());
  }

  List<ListCustomerModel> model = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Customer"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
        child: BlocListener<ListCustomerBloc, ListCustomerState>(
          listener: (context, state) {
            if (state is ListCustomerLoaded) {
              model = state.listCustomerModel;
            }
          },
          child: BlocBuilder<ListCustomerBloc, ListCustomerState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search Customer",
                        fillColor: primaryColor,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isEmpty) {
                          BlocProvider.of<ListCustomerBloc>(context)
                              .add(ListCustomerEventStarted());
                        } else {
                          BlocProvider.of<ListCustomerBloc>(context).add(
                              ListCustomerEventSearch(
                                  model: model, searchKey: value));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ListCustomerLoading)
                      const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor)),
                      )
                    else
                      Flexible(
                        child: ListView.builder(
                            itemCount: model.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Container(
                                    height: 30,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      model[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // leading: Container(
                                  //     margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                  //     child: const Icon(
                                  //       Icons.circle,
                                  //       color: primaryColor,
                                  //     )),
                                  subtitle: Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text(
                                      model[index].alamat,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  trailing: Container(
                                    height: 30,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: primaryColor,
                                    ),
                                  ),
                                  onTap: () {
                                    List<dynamic> arr = [
                                      model[index].id,
                                      model[index].name,
                                      model[index].dm,
                                    ];
                                    Navigator.pop(context, arr);
                                  },
                                ),
                              );
                            }),
                      )
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

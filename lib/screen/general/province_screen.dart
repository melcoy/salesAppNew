import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/customer/list_customer/bloc/list_customer_bloc.dart';
import 'package:sales_app/bloc/general/city/bloc/city_bloc.dart';
import 'package:sales_app/bloc/general/province/bloc/province_bloc.dart';

import 'package:sales_app/models/general/kota_model.dart';
import 'package:sales_app/models/general/provinsi_model.dart';
import 'package:sales_app/shared/constant.dart';

import 'package:sales_app/shared/theme.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({Key? key}) : super(key: key);

  @override
  _ProvinceScreenState createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProvinceBloc>(context).add(ProvinceEventStarted());
  }

  List<ProvinsiModel> model = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Province"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
        child: BlocListener<ProvinceBloc, ProvinceState>(
          listener: (context, state) {
            if (state is ProvinceLoaded) {
              model = state.model;
            }
          },
          child: BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "Search Province",
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
                          BlocProvider.of<ProvinceBloc>(context)
                              .add(ProvinceEventStarted());
                        } else {
                          BlocProvider.of<ProvinceBloc>(context).add(
                              ProvinceEventSearch(
                                  model: model, searchKey: value));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ProvinceLoading)
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
                              return ListTile(
                                title: Container(
                                  height: 30,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    model[index].name,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // leading: Container(Text(

                                //     margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                //     child: const Icon(
                                //       Icons.circle,
                                //       color: primaryColor,
                                //     )),
                                // subtitle: Container(
                                //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                //   child: Text(
                                //     model[index].alamat,
                                //     maxLines: 3,
                                //     softWrap: true,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //             color: primaryColor,
                                //             fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                trailing: Container(
                                  height: 30,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: primaryColor,
                                  ),
                                ),
                                onTap: () {
                                  List<dynamic> arr = [
                                    model[index].id,
                                    model[index].name,
                                  ];
                                  Navigator.pop(context, arr);
                                },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/customer/list_customer/bloc/list_customer_bloc.dart';
import 'package:sales_app/bloc/spesification/search/list_truck_search/bloc/list_truck_search_bloc.dart';
import 'package:sales_app/models/spesification/dto/list_truck_dto.dart';
import 'package:sales_app/shared/size_config.dart';

import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_loading_dialog.dart';

class SearchTruck extends StatefulWidget {
  final bool? search;
  const SearchTruck({this.search, Key? key}) : super(key: key);

  @override
  _SearchTruckState createState() => _SearchTruckState();
}

class _SearchTruckState extends State<SearchTruck> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListTruckSearchBloc>(context)
        .add(ListTruckSearchEventStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Search Truck"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {},
        ),
      ),
      body: SafeArea(
        child: BlocListener<ListTruckSearchBloc, ListTruckSearchState>(
          listener: (context, state) {
            if (state is ListTruckSearchLoading) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return LoadingDialog(message: "Please Wait");
                },
              );
            }
            if (state is ListTruckSearchLoaded) {
              Navigator.pop(context);
            }
          },
          child: BlocBuilder<ListTruckSearchBloc, ListTruckSearchState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // TextField(
                    //   decoration: const InputDecoration(
                    //     prefixIcon: Icon(Icons.search),
                    //     labelText: "Search Customer",
                    //     fillColor: primaryColor,
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: primaryColor,
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: primaryColor,
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //   ),
                    //   onChanged: (value) {},
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ListTruckSearchLoaded)
                      Flexible(
                        child: ListView.builder(
                            itemCount: state.listAllProduct.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  height: SizeConfig.blockVertical * 15,
                                  width: double.maxFinite,
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Container(
                                        height: SizeConfig.blockVertical * 15,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: Text(
                                          state.listAllProduct[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      SizeConfig.blockVertical *
                                                          2),
                                        ),
                                      ),
                                      // subtitle: Text(
                                      //   state.listAllProduct[index].deskripsi,
                                      //   maxLines: 3,
                                      //   softWrap: true,
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodyText1!
                                      //       .copyWith(
                                      //           color: Colors.black38,
                                      //           fontWeight: FontWeight.bold),
                                      // ),
                                      leading: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 25, 0, 0),
                                          child: const Icon(
                                            Icons.circle,
                                            color: primaryColor,
                                          )),
                                      trailing: Container(
                                        height: 30,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: primaryColor,
                                        ),
                                      ),
                                      onTap: () {
                                        List<String> nameBonus = [];
                                        for (int i = 0;
                                            i <
                                                state.listAllProduct[index]
                                                    .bonus.length;
                                            i++) {
                                          nameBonus.add(state
                                              .listAllProduct[index]
                                              .bonus[i]
                                              .name);
                                        }
                                        ListTruckDto model = ListTruckDto(
                                            bonus: nameBonus,
                                            discount: state
                                                .listAllProduct[index].discount,
                                            id: state.listAllProduct[index].id,
                                            type: state
                                                .listAllProduct[index].name,
                                            harga: state
                                                .listAllProduct[index].harga);

                                        Navigator.pop(context, model);
                                        // List<dynamic> arr = [
                                        //   state.listCustomerModel[index].id,
                                        //   state.listCustomerModel[index].name,
                                        //   state.listCustomerModel[index].dm,
                                        // ];
                                        // Navigator.pop(context, arr);
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return CustomerDetail(
                                        //     name: _listCustomerModel[index].name,
                                        //     address:
                                        //         _listCustomerModel[index].alamat,
                                        //     decision:
                                        //         _listCustomerModel[index].dm,
                                        //     kecamatan: _listCustomerModel[index]
                                        //         .kecamatan,
                                        //     kelurahan: _listCustomerModel[index]
                                        //         .kelurahan,
                                        //     kodepos:
                                        //         _listCustomerModel[index].kodepos,
                                        //     kota: _listCustomerModel[index].kota,
                                        //     provinsi: _listCustomerModel[index]
                                        //         .provinsi,
                                        //   );
                                        // }));

                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return CustomerDetail(
                                        //     name: _listCustomerModel[index].name,
                                        //     address: _listCustomerModel[index].alamat,
                                        //     decision: _listCustomerModel[index].dm,
                                        //     kecamatan:
                                        //         _listCustomerModel[index].kecamatan,
                                        //     kelurahan:
                                        //         _listCustomerModel[index].kelurahan,
                                        //     kodepos: _listCustomerModel[index].kodepos,
                                        //     kota: _listCustomerModel[index].kota,
                                        //     provinsi:
                                        //         _listCustomerModel[index].provinsi,
                                        //   );
                                        // }));
                                      },
                                    ),
                                  ));
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

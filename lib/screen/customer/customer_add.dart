import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_app/bloc/customer/customer_add/bloc/customer_add_bloc.dart';
import 'package:sales_app/models/customer/dto/customer_add_dto.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';

import 'package:sales_app/shared/theme.dart';
import 'package:sales_app/shared/widget/fd_button.dart';
import 'package:sales_app/shared/widget/fd_spacer.dart';
import 'package:sales_app/shared/widget/fd_square_texfield.dart';

class CustomerAdd extends StatefulWidget {
  const CustomerAdd({Key? key}) : super(key: key);

  @override
  _CustomerAddState createState() => _CustomerAddState();
}

class _CustomerAddState extends State<CustomerAdd> {
  TextEditingController prospectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedSalution = "";
  List salution = ["Men", "Women"];
  String provinceId = "";
  String cityId = "";
  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: Theme.of(context).primaryColor,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Customer Add",
            style: TextStyle(color: primaryColor),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: primaryColor,
            ),
            onPressed: () {},
          ),
        ),
        body: SafeArea(
            child: BlocListener<CustomerAddBloc, CustomerAddState>(
          listener: (context, state) {
            if (state is CustomerAddSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: Text(state.succMsg.toString())));
              Navigator.pushReplacementNamed(context, customerRoute);
            }
            if (state is CustomerAddFaillure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 4),
                  content: Text(state.errMsg.toString())));
            }
          },
          child: BlocBuilder<CustomerAddBloc, CustomerAddState>(
            builder: (context, state) {
              return ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FDSquareTextfield(
                          readOnly: false,
                          label: const Text(
                            "Prospect",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          maxLine: 1,
                          controller: prospectController,
                          typeKeyboard: false,
                          onTap: () {},
                        ),
                        const VerticalSpace(),
                        FDSquareTextfield(
                          readOnly: false,
                          label: const Text(
                            "Address",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          maxLine: 3,
                          controller: addressController,
                          typeKeyboard: false,
                          onTap: () {},
                        ),
                        const VerticalSpace(),
                        FDSquareTextfield(
                          readOnly: false,
                          label: const Text(
                            "Phone Number",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          maxLine: 1,
                          controller: phoneController,
                          typeKeyboard: true,
                        ),
                        const VerticalSpace(),
                        FDSquareTextfield(
                          readOnly: false,
                          label: const Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          emailText: true,
                          maxLine: 1,
                          controller: emailController,
                          typeKeyboard: false,
                          onTap: () {},
                        ),
                        const VerticalSpace(),
                        Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 120,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: defaultRadiusValue,
                                  topRight: defaultRadiusValue,
                                ),
                              ),
                              child: const Text(
                                "Gender",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: borderSide,
                                  top: borderSide,
                                  right: borderSide,
                                  bottom: borderSide,
                                ),
                              ),
                              child: DropdownButtonFormField<dynamic>(
                                hint: const Text(
                                  'Gender',
                                ),
                                onChanged: (salution) => setState(() {
                                  selectedSalution = salution;
                                }),
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                items: salution.map((valueItem) {
                                  return DropdownMenuItem(
                                      value: valueItem, child: Text(valueItem));
                                }).toList(),
                              ),
                            ),
                          ],
                        )),
                        const VerticalSpace(),
                        FDSquareTextfield(
                          readOnly: true,
                          label: const Text(
                            "Province",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          emailText: false,
                          maxLine: 1,
                          controller: provinceController,
                          typeKeyboard: false,
                          onTap: () async {
                            var data = await Navigator.pushNamed(
                                context, provinceRoute);
                            if (data != null) {
                              var data2 = data as List<dynamic>;
                              provinceId = data2[0].toString();
                              provinceController.text =
                                  data2[1].toString().toLowerCase();

                              setState(() {});
                            }
                          },
                        ),
                        const VerticalSpace(),
                        FDSquareTextfield(
                          readOnly: true,
                          label: const Text(
                            "City",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          emailText: false,
                          maxLine: 1,
                          controller: cityController,
                          typeKeyboard: false,
                          onTap: () async {
                            var data =
                                await Navigator.pushNamed(context, cityRoute);
                            if (data != null) {
                              var data2 = data as List<dynamic>;
                              cityId = data2[0].toString();
                              cityController.text =
                                  data2[1].toString().toLowerCase();

                              setState(() {});
                            }
                          },
                        ),
                        const VerticalSpace(),
                        if (state is CustomerAddLoading)
                          const Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    primaryColor)),
                          )
                        else
                          FDButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  cityId != "" &&
                                  provinceId != "") {
                                BlocProvider.of<CustomerAddBloc>(context).add(
                                    CustomerAddBlocEventSave(CustomerAddDto(
                                        kota: cityId,
                                        provinsi: provinceId,
                                        alamat: addressController.text,
                                        hp: phoneController.text,
                                        email: emailController.text,
                                        name: prospectController.text,
                                        sex: selectedSalution)));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 2),
                                        content:
                                            Text("Please Complete the Field")));
                              }
                            },
                            text: "Add Customer",
                            textColor: Colors.white,
                          ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        )));
  }
}

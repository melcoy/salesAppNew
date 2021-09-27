import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_place/google_place.dart';
import 'package:sales_app/shared/constant.dart';
import 'package:sales_app/shared/size_config.dart';
import 'package:sales_app/shared/theme.dart';

class SearchAddressGoogle extends StatefulWidget {
  const SearchAddressGoogle({Key? key}) : super(key: key);

  @override
  _SearchAddressGoogleState createState() => _SearchAddressGoogleState();
}

class _SearchAddressGoogleState extends State<SearchAddressGoogle> {
  GooglePlace? googlePlace;
  GeoCode geoCode = GeoCode();
  List<AutocompletePrediction> predictions = [];
  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace(googleKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Address"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () async {
            // var googlePlace =
            //     GooglePlace("AIzaSyDT-n0Mg--DSmdCk3FTADdpTkea1qzojB8");
            // var risult =
            //     await googlePlace.queryAutocomplete.get("pizza near sydne");
            // print(risult!.predictions![1].description);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: "Search Address",
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
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(predictions[index].description!),
                      onTap: () async {
                        Navigator.pop(context,
                            predictions[index].description!.toString());
                        // debugPrint(predictions[index].placeId);
                        // Coordinates coordinates =
                        //     await geoCode.forwardGeocoding(
                        //         address: predictions[index].description!);
                        // Address address = await geoCode.reverseGeocoding(
                        //     latitude: double.parse("-6.92992"),
                        //     longitude: double.parse("107.63719"));
                        // print("Adress" + address.postal.toString());

                        // print("Latitude: ${coordinates.latitude}");
                        // print("Longitude: ${coordinates.longitude}");
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DetailsPage(
                        //       placeId: predictions[index].placeId,
                        //       googlePlace: googlePlace,
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
              ),

              // Container(
              //   margin: EdgeInsets.only(top: 10, bottom: 10),
              //   child: Image.asset("assets/powered_by_google.png"),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    List<Component> listComp = [];

    Component comp = Component("country", "idn");
    listComp.add(comp);
    var result =
        await googlePlace!.autocomplete.get(value, components: listComp);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}

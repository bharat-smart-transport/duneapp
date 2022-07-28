import 'dart:convert';

import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';

import '../../Provider/main_provider.dart';
import 'dart:io' as Io;

PickedFile? materialImage;
String materiallink = "";
String selfie64 = "";

PickedFile? billPhoto;
String billlink = "";
String bill64 = "";

class LoadVehicle extends StatefulWidget {
  String? id;
  LoadVehicle({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  State<LoadVehicle> createState() => _LoadVehicleState();
}

class _LoadVehicleState extends State<LoadVehicle> {
  bool? checkedValue = true;
  bool? currentSame = true;
  String? vehicleType = "Select Vehicle Type";
  String? baseRouteFrom = "Base Route From";
  String? enterQuantity = "Ton";
  String? baseRouteTo = "Base Route To";
  String? currentRouteFrom = "Current Route From";
  String? currentRouteTo = "Current Route To";
  String? materialCategory = "Material Category";
  String? materialSubCategory = "Material Sub Category";
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController askPrice = TextEditingController();
  TextEditingController loadCapacity = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController driverNumber = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    vehicleNumber.dispose();
    loadCapacity.dispose();
    driverName.dispose();
    driverNumber.dispose();
  }

  void _openCamera(
      BuildContext context, PickedFile pickedFilee, String imagelink) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    setState(() {
      pickedFilee = pickedFile!;
    });
    print("imageFile");
    imagelink = pickedFile!.path.toString();
    final bytes = Io.File(imagelink).readAsBytesSync();
    selfie64 = base64Encode(bytes);
    print(selfie64);
  }

  @override
  void initState() {
    billPhoto = null;
    materialImage = null;
    print(Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .driverPermissionToSell);
    checkedValue = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .driverPermissionToSell;
    vehicleType = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .vehicleType;
    baseRouteFrom = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .baseRouteFrom;
    baseRouteTo = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .baseRouteTo;
    enterQuantity = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .loadCapacityUnit
        .toString();
    materialCategory = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .materialCategory;
    materialSubCategory = Provider.of<MainProvider>(context, listen: false)
        .specificVehicle!
        .data
        .materialSubCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Essentials.hexToColor("#f5f5f5"),
        appBar: AppBar(
          backgroundColor: Essentials.hexToColor("#0390d7"),
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          title: Text(AppLocalizations.of(context)!.load_vehicle.toUpperCase()),
        ),
        body: Consumer<MainProvider>(
          builder: (_, a, __) {
            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                a.specificVehicle!.data.image == null
                    ? Image.asset(
                        "assets/select_image.png",
                        height: 150,
                      )
                    : Container(
                        height: Dimension.scalePixel(70),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          a.specificVehicle!.data.image,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    enabled: false,
                    controller: vehicleNumber
                      ..text = a.specificVehicle!.data.vehicleNo,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.vehicle_number,
                      hintText: AppLocalizations.of(context)!.vehicle_number,
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    enabled: false,
                    initialValue: a.specificVehicle!.data.vehicleType,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.vehicle_type,
                      hintText: AppLocalizations.of(context)!.vehicle_type,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                // Material(
                //   child:
                // ),
                Material(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: loadCapacity
                            ..text =
                                a.specificVehicle!.data.loadCapacity.toString(),
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.vehicle_capacity,
                            labelText:
                                AppLocalizations.of(context)!.vehicle_capacity,
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          initialValue: enterQuantity.toString(),
                          decoration: const InputDecoration(
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabled: false,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    enabled: false,
                    initialValue: a.specificVehicle!.data.baseRouteFrom,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.base_route_from,
                      hintText: AppLocalizations.of(context)!.base_route_from,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    enabled: false,
                    initialValue: a.specificVehicle!.data.baseRouteTo,
                    autofocus: false,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.base_route_to,
                      hintText: AppLocalizations.of(context)!.base_route_to,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CheckboxListTile(
                  title: Text(
                    AppLocalizations.of(context)!
                        .if_current_route_is_same_as_base_route,
                  ),
                  value: currentSame,
                  onChanged: (newValue) {
                    setState(() {
                      currentSame = newValue;
                      print(currentSame);
                    });
                    if (newValue == true) {
                      setState(() {
                        currentRouteFrom = baseRouteFrom;
                        currentRouteTo = baseRouteTo;
                        print(currentRouteFrom);
                        print(currentRouteTo);
                      });
                    }
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                const SizedBox(
                  height: 15,
                ),
                currentSame == false
                    ? Material(
                        color: Colors.white,
                        // elevation: 1.0,
                        shadowColor: Essentials.hexToColor("#707070"),
                        child: DropdownButtonFormField(
                          hint: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text(a.specificVehicle!.data.baseRouteFrom
                                  .toString()),
                            ],
                          ),
                          items: <String>['Mohali', 'Chandigarh']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            currentRouteFrom = value;
                          },
                          decoration: InputDecoration(
                            enabled: false,
                            labelText:
                                AppLocalizations.of(context)!.base_route_from,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      )
                    : TextFormField(
                        enabled: false,
                        initialValue: a.specificVehicle!.data.baseRouteFrom,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.base_route_from,
                          hintText:
                              AppLocalizations.of(context)!.base_route_from,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 3.0),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                currentSame == false
                    ? Material(
                        color: Colors.white,
                        // elevation: 1.0,
                        shadowColor: Essentials.hexToColor("#707070"),
                        child: DropdownButtonFormField(
                          hint: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text(a.specificVehicle!.data.baseRouteTo
                                  .toString()),
                            ],
                          ),
                          items: <String>['Mohali', 'Chandigarh']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            currentRouteTo = value;
                          },
                          decoration: InputDecoration(
                            enabled: false,
                            labelText:
                                AppLocalizations.of(context)!.base_route_to,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      )
                    : TextFormField(
                        enabled: false,
                        initialValue: a.specificVehicle!.data.baseRouteTo,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.base_route_to,
                          hintText: AppLocalizations.of(context)!.base_route_to,
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 3.0),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),

                ListTile(
                  leading: materialImage == null
                      ? FlatButton(
                          color: Colors.grey,
                          onPressed: () {
                            _openCamera(context, materialImage!, materiallink);
                          },
                          child: Text("Choose File"),
                        )
                      : FlatButton(
                          onPressed: () {},
                          color: Colors.white,
                          child: Text("Choose File"),
                        ),
                  title: materialImage == null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          color: Colors.white,
                          child: Text("No File Chosen"))
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          color: Colors.white,
                          child: Text(
                            materiallink,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
                Divider(
                  color: Essentials.hexToColor("#707070"),
                  thickness: 0.8,
                ),
                Material(
                  color: Colors.white,
                  // elevation: 1.0,
                  shadowColor: Essentials.hexToColor("#707070"),
                  child: DropdownButtonFormField(
                    hint: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(a.specificVehicle!.data.materialCategory
                            .toString()),
                      ],
                    ),
                    items: <String>['Rodi', 'Matter'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      materialCategory = value;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .select_material_category,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  color: Colors.white,
                  // elevation: 1.0,
                  shadowColor: Essentials.hexToColor("#707070"),
                  child: DropdownButtonFormField(
                    hint: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        Text(a.specificVehicle!.data.materialSubCategory
                            .toString()),
                      ],
                    ),
                    items: <String>['Rodi', 'Matter'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      materialSubCategory = value;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .select_material_subcategory,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    controller: askPrice,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.ask_price,
                      labelText: AppLocalizations.of(context)!.ask_price,
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(),
                const SizedBox(
                  height: 15,
                ),
                Material(
                  child: TextFormField(
                    enabled: false,
                    controller: driverName
                      ..text = a.specificVehicle!.data.driver.name,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.enter_drivers_name,
                      labelText:
                          AppLocalizations.of(context)!.enter_drivers_name,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),

                CheckboxListTile(
                  title: Text(AppLocalizations.of(context)!
                      .the_driver_has_permission_to_sell_load),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                const SizedBox(
                  height: 15,
                ),

                ListTile(
                  leading: billPhoto == null
                      ? FlatButton(
                          color: Colors.grey,
                          onPressed: () {
                            _openCamera(context, billPhoto!, billlink);
                          },
                          child: Text("Choose File"),
                        )
                      : FlatButton(
                          onPressed: () {},
                          color: Colors.white,
                          child: Text("Choose File"),
                        ),
                  title: materialImage == null
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          color: Colors.white,
                          child: Text("No File Chosen"))
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          color: Colors.white,
                          child: Text(
                            billlink,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                ),
                Divider(
                  color: Essentials.hexToColor("#707070"),
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Essentials.hexToColor("#727272"),
                            ),
                            color: Essentials.hexToColor("#727272")
                                .withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .delete
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (askPrice.text.toString() == "") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!.enter_ask_price,
                                ),
                              ),
                            );
                          } else if (currentRouteFrom == "") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .enter_base_route_from,
                                ),
                              ),
                            );
                          } else if (currentRouteTo == "") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .enter_base_route_to,
                                ),
                              ),
                            );
                          } else if (enterQuantity.toString() == "") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!.enter_quantuty,
                                ),
                              ),
                            );
                          } else if (materialCategory == "Material Category") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .select_material_category,
                                ),
                              ),
                            );
                          } else if (materialSubCategory ==
                              "Material Sub Category") {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .select_material_subcategory,
                                ),
                              ),
                            );
                          } else if (billlink.isEmpty) {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .enter_bill_photo,
                                ),
                              ),
                            );
                          } else if (materiallink.isEmpty) {
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 5),
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .enter_material_photo,
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              loading = true;
                            });
                            Essentials.showProgressDialog(context);
                            final dynamic res = await Provider.of<MainProvider>(
                                    context,
                                    listen: false)
                                .loadVehicle(
                                    widget.id.toString(),
                                    currentRouteFrom.toString(),
                                    currentRouteTo.toString(),
                                    "LOADED",
                                    askPrice.text.toString(),
                                    billlink,
                                    materiallink);
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                            if (res == "Success") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            } else {
                              _scaffoldKey.currentState
                                  // ignore: deprecated_member_use
                                  ?.showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 5),
                                  // fill_all_the_details
                                  content: Text(
                                    AppLocalizations.of(context)!.failed,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Essentials.hexToColor("#0390d7"),
                            ),
                            color: Essentials.hexToColor("#0390d7")
                                .withOpacity(0.7),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .update
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }
}

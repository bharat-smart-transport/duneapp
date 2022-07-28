import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? vehicleType = "Select Vehicle Type";
  String? vehicleSubType = "Select Vehicle Subcategory Type";
  String? materialCategory = "Material Category";
  String? materialSubCategory = "Material SubCategory";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Essentials.hexToColor("#0390d7"),
        title: const Text("Filter"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
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
                  Text(vehicleType.toString()),
                ],
              ),
              items: <String>['TRUCK', 'TROLLEY'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                vehicleType = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.select_vehicle_type,
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
                  Text(vehicleSubType.toString()),
                ],
              ),
              items: <String>['16 TYRE', '14 TYRE'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                vehicleSubType = value;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.select_vehicle_type,
                contentPadding: const EdgeInsets.all(15),
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
                  Text(materialCategory.toString()),
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
                border: OutlineInputBorder(),
                labelText:
                    AppLocalizations.of(context)!.select_material_category,
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
                  Text(materialCategory.toString()),
                ],
              ),
              items: <String>['Small', 'Large'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                materialCategory = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText:
                    AppLocalizations.of(context)!.select_material_category,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<MainProvider>(
            builder: (_, a, __) {
              return Center(
                child: BlockButtonWidget(
                  color: Theme.of(context).primaryColor,
                  text: Text(
                    "APPLY",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  onPressed: () async {
                    var res = await a.filter(
                      vehicleType!,
                      vehicleSubType!,
                      materialCategory!,
                      materialSubCategory!,
                    );
                    if (res == "Success") {
                      _scaffoldKey.currentState
                          // ignore: deprecated_member_use
                          ?.showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 5),
                          // fill_all_the_details
                          content: Text(
                            AppLocalizations.of(context)!.success,
                          ),
                        ),
                      );
                      Navigator.pop(context);
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
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}


// Center(
          //     child: BlockButtonWidget(
          //       color: Theme.of(context).primaryColor,
          //       text: Text(
          //         "APPLY",
          //         style: Theme.of(context).textTheme.headline2,
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
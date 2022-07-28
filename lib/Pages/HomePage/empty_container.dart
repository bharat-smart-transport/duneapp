import 'package:dune/Pages/HomePage/edit_page.dart';
import 'package:dune/Pages/HomePage/load_vehicle.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EmptyContainer extends StatefulWidget {
  String? id;
  String? vehicleNo;
  String? capacityUnit;
  String? vehicleName;
  String? truckCapacity;
  String? driverName;
  EmptyContainer({
    Key? key,
    required this.id,
    required this.vehicleNo,
    required this.capacityUnit,
    required this.vehicleName,
    required this.truckCapacity,
    required this.driverName,
  }) : super(key: key);

  @override
  State<EmptyContainer> createState() => _EmptyContainerState();
}

class _EmptyContainerState extends State<EmptyContainer> {
  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Essentials.hexToColor("#666666"),
        ),
        color: Essentials.hexToColor("#f5f5f5").withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.vehicleNo}",
                style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
              ),
              Text(
                "${AppLocalizations.of(context)!.truck_capacity}: ${widget.truckCapacity} ${widget.capacityUnit}",
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.vehicleName}",
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Consumer<MainProvider>(
            builder: (_, a, __) {
              return a.userDetails!.data.userType == "CUSTOMER"
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            Essentials.showProgressDialog(context);
                            String token = await SharedPrefs.getData("token");
                            // ignore: use_build_context_synchronously
                            await Provider.of<MainProvider>(context,
                                    listen: false)
                                .getVehicleById(widget.id.toString(), token);
                            setState(() {
                              loading = false;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPage(
                                          id: widget.id.toString(),
                                        )));
                          },
                          child: Container(
                              height: 35,
                              padding: const EdgeInsets.all(5),
                              // width: Dimension.scalePixel(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Essentials.hexToColor("#f5f5f5")
                                    .withOpacity(0.1),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .edit
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              loading = true;
                            });
                            Essentials.showProgressDialog(context);
                            String token = await SharedPrefs.getData("token");
                            // ignore: use_build_context_synchronously
                            await Provider.of<MainProvider>(context,
                                    listen: false)
                                .getVehicleById(widget.id.toString(), token);
                            setState(() {
                              loading = false;
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadVehicle(
                                  id: widget.id.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 35,
                            padding: const EdgeInsets.all(5),
                            width: Dimension.scalePixel(25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Essentials.hexToColor("#0390d7"),
                              ),
                              color: Essentials.hexToColor("#f5f5f5")
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.load_material,
                                style: TextStyle(
                                  color: Essentials.hexToColor("#0390d7"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}

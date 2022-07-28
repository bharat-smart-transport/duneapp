import 'package:dune/Pages/Auth/login.dart';
import 'package:dune/Pages/HomePage/bid/bid_vehicle.dart';
import 'package:dune/Pages/HomePage/bid_vehicle.dart';
import 'package:dune/Pages/HomePage/edit_page.dart';
import 'package:dune/Pages/HomePage/load_vehicle.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../Provider/main_provider.dart';

class LoadedContainer extends StatefulWidget {
  String? id;
  String? vehicleNo;
  String? vehicleName;
  String? askPrice;
  String truckMaterial;
  String? truckCapacity;
  String? truckCapacityUnit;
  String? driverName;
  LoadedContainer({
    Key? key,
    required this.id,
    required this.truckMaterial,
    required this.vehicleNo,
    required this.askPrice,
    required this.vehicleName,
    required this.truckCapacity,
    required this.truckCapacityUnit,
    required this.driverName,
  }) : super(key: key);

  @override
  State<LoadedContainer> createState() => _LoadedContainerState();
}

class _LoadedContainerState extends State<LoadedContainer> {
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
          color: Essentials.hexToColor("#ffc107"),
        ),
        color: Essentials.hexToColor("#ffc107").withOpacity(0.2),
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
                "${AppLocalizations.of(context)!.selling_price}: ${widget.askPrice}/Q",
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
                "${widget.driverName}",
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
              Text(
                "${AppLocalizations.of(context)!.load}: ${widget.truckCapacity} ${widget.truckCapacityUnit}",
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
                  ? Container(
                      child: InkWell(
                        onTap: () async {
                          Essentials.showProgressDialog(context);
                          await Provider.of<MainProvider>(context,
                                  listen: false)
                              .getBid(widget.id.toString());
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BidVehicle(
                                vehicleId: widget.id.toString(),
                                vehicleNo: widget.vehicleNo.toString(),
                                driverName: widget.driverName!,
                                driverNumber: widget.driverName!,
                                truckLoad: widget.truckCapacity!,
                                truckCapacityUnit: widget.truckCapacityUnit!,
                                truckAskPrice: widget.askPrice!,
                                truckMaterial: widget.truckMaterial,
                                location: "location",
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!
                              .bid_vehicle
                              .toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            Essentials.showProgressDialog(context);
                            String token = await SharedPrefs.getData("token");
                            print(token);
                            // ignore: use_build_context_synchronously
                            await Provider.of<MainProvider>(context,
                                    listen: false)
                                .getVehicleById(widget.id.toString(), token);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(
                                  id: widget.id.toString(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!.edit.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Essentials.showProgressDialog(context);
                            await Provider.of<MainProvider>(context,
                                    listen: false)
                                .getBid(widget.id.toString());
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BidVehicle(
                                  vehicleId: widget.id.toString(),
                                  vehicleNo: widget.vehicleNo.toString(),
                                  driverName: widget.driverName!,
                                  driverNumber: widget.driverName!,
                                  truckLoad: widget.truckCapacity!,
                                  truckCapacityUnit: widget.truckCapacityUnit!,
                                  truckAskPrice: widget.askPrice!,
                                  truckMaterial: widget.truckMaterial,
                                  location: "location",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .bid_vehicle
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Essentials.showProgressDialog(context);
                            String token = await SharedPrefs.getData("token");
                            print(token);
                            final dynamic res = await Provider.of<MainProvider>(
                                    context,
                                    listen: false)
                                .getVehicleById(widget.id.toString(), token);
                            if (res == "Failed") {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }
                            Navigator.pop(context);
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
                            width: Dimension.scalePixel(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Essentials.hexToColor("#f5f5f5")
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .edit_load_material
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
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

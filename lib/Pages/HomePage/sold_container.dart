import 'package:dune/Pages/HomePage/sold_vehicle.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SoldContainer extends StatefulWidget {
  String? id;
  String? vehicleNo;
  String? vehicleName;
  String? askPrice;
  String? truckCapacity;
  String? truckCapacityUnit;
  String? driverName;
  SoldContainer({
    Key? key,
    required this.id,
    required this.vehicleNo,
    required this.askPrice,
    required this.vehicleName,
    required this.truckCapacity,
    required this.truckCapacityUnit,
    required this.driverName,
  }) : super(key: key);

  @override
  State<SoldContainer> createState() => _SoldContainerState();
}

class _SoldContainerState extends State<SoldContainer> {
  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SoldVehiclePage()));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        height: Dimension.scalePixel(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Essentials.hexToColor("#1ebf00"),
          ),
          color: Essentials.hexToColor("#1ebf00").withOpacity(0.2),
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
                  "${AppLocalizations.of(context)!.deal_price}: ${widget.askPrice}/Q",
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
                  "${AppLocalizations.of(context)!.load}: ${widget.truckCapacity}Kg",
                  style: Theme.of(context).textTheme.bodyText1!.merge(
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

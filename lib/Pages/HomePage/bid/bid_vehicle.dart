import 'dart:math';

import 'package:counter/counter.dart';
import 'package:dune/Pages/side_drawer.dart';
import 'package:dune/components/button.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:dune/config.dart';
import 'package:provider/provider.dart';

import '../../../Provider/main_provider.dart';
import '../../../Services/essentials.dart';

// ignore: must_be_immutable
class BidVehicle extends StatefulWidget {
  String driverName;
  String driverNumber;
  String truckLoad;
  String vehicleNo;
  String vehicleId;
  String truckCapacityUnit;
  String truckAskPrice;
  String truckMaterial;
  String location;
  BidVehicle({
    Key? key,
    required this.driverName,
    required this.vehicleNo,
    required this.vehicleId,
    required this.truckCapacityUnit,
    required this.driverNumber,
    required this.truckLoad,
    required this.truckAskPrice,
    required this.truckMaterial,
    required this.location,
  }) : super(key: key);

  @override
  State<BidVehicle> createState() => _BidVehicleState();
}

class _BidVehicleState extends State<BidVehicle> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int askPrice = 0;
  void showSavePopUp(context) async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      return await showDialog(
          context: context,
          builder: (BuildContext context) {
            Dimension.init(context);
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  content: SizedBox(
                    height: Dimension.scalePixel(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.please_add_bid),
                        const SizedBox(height: 20),
                        Counter(
                          min: 0,

                          /// max value
                          max: 100,

                          /// bound value, default null，must be greater than or equal to [min] and less than or equal to [max].
                          /// current value can not be greater than [min] and less than bound if bound is not null and its approved.
                          /// if current value is [min], and bound value greater than [min] too, and the value will be change with bound value by one step after inscrease button clicked.
                          /// and it will be 0change with [min] value by one step after descrease button clicked.
                          bound: 3,

                          /// initial value, default equal to [min], must be greater than or equal to [min] and less than or equal to [max].
                          /// and initial value must be greater or equal to [bound], while bound and initial value both not be null.
                          initial: 5,

                          /// stepper，default 1
                          step: 1,

                          /// appearance configuration，default DefaultConfiguration()
                          /// you can also set up custom appearance by implements [Configuration] class.
                          configuration: DefaultConfiguration(),

                          /// value changed callback.
                          onValueChanged: (value) {
                            askPrice = value.toInt();
                            print("-----------------");
                            print(askPrice);
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .no
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Essentials.hexToColor("#727272"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            // createBid
                            Expanded(
                                child: ElevatedButton(
                              onPressed: () async {
                                Essentials.showProgressDialog(context);
                                await Provider.of<MainProvider>(context,
                                        listen: false)
                                    .createBid(
                                  widget.vehicleId.toString(),
                                  askPrice.toString(),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.yes.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Essentials.hexToColor("#0390d7"),
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          });
    });
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  String? id;
  String? userType;
  getId() async {
    String? Id = await SharedPrefs.getData("id");
    String? UserType = await SharedPrefs.getData("userType");
    setState(() {
      id = Id;
      userType = UserType;
      print(userType);
    });
  }

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bid_vehicle),
        backgroundColor: Essentials.hexToColor("#0390d7"),
      ),
      drawer: const SideDrawer(),
      body: Column(
        children: [
          Container(
            height: Dimension.scalePixel(70),
            decoration: BoxDecoration(
              color: Essentials.hexToColor("#ffc107").withOpacity(0.1),
              border: Border.all(
                color: Essentials.hexToColor("#ffc107"),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.vehicleNo}",
                          style: Theme.of(context).textTheme.headline1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                        Text(
                          "${widget.driverName}",
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                        ),
                        Row(
                          children: [
                            Text(
                              // load
                              "${AppLocalizations.of(context)!.load}:    ",
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                            ),
                            Text(
                              "${widget.truckLoad} ${widget.truckCapacityUnit}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(TextStyle(
                                    color: Essentials.hexToColor("#ffc107"),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.deal_price}:    ",
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                            ),
                            Text(
                              "${widget.truckAskPrice} / Q ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(TextStyle(
                                    color: Essentials.hexToColor("#ffc107"),
                                  )),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.material}:    ",
                              style:
                                  Theme.of(context).textTheme.bodyText1!.merge(
                                        const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                            ),
                            Text(
                              "${widget.truckMaterial} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(TextStyle(
                                    color: Essentials.hexToColor("#ffc107"),
                                  )),
                            ),
                          ],
                        ),
                        Text(
                          "Last Location ",
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Consumer<MainProvider>(
                          builder: (_, a, __) {
                            return a.userDetails!.data.userType == "CUSTOMER"
                                ? BlockButtonWidget(
                                    color: Essentials.hexToColor("#ffc107"),
                                    text: Text(
                                      AppLocalizations.of(context)!.make_offer,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      showSavePopUp(context);
                                    },
                                  )
                                : Container();
                          },
                        ),
                      ],
                    ),
                    const Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        backgroundImage: AssetImage('assets/Group 2072.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              thickness: 1.5,
              color: Essentials.hexToColor("#ffc107").withOpacity(0.4),
            ),
          ),
          Consumer<MainProvider>(
            builder: (_, a, __) {
              return Expanded(
                child: ListView.builder(
                    itemCount:
                        a.getBids == null ? 0 : a.getBids!.requests.length,
                    itemBuilder: (context, index) {
                      if (a.getBids!.requests[index].toBeShownTo.contains(id)) {
                        if (a.getBids!.requests[index].requestStatus ==
                            "LIVE") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Essentials.hexToColor("#ffc107")
                                  .withOpacity(0.1),
                              border: Border.all(
                                color: Essentials.hexToColor("#ffc107"),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${a.getBids!.requests[index].price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        widget.driverName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.deal_price}: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        ),
                                        Text(
                                          "${a.getBids!.requests[index].price} / Q ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(TextStyle(
                                                color: Essentials.hexToColor(
                                                    "#ffc107"),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Essentials.showProgressDialog(
                                                context);
                                            final dynamic res =
                                                await Provider.of<MainProvider>(
                                                        context,
                                                        listen: false)
                                                    .rejectReqeust(
                                              a.getBids!.requests[index].id,
                                              widget.vehicleId,
                                            );
                                            Navigator.pop(context);
                                            _scaffoldKey.currentState
                                                // ignore: deprecated_member_use
                                                ?.showSnackBar(
                                              SnackBar(
                                                duration:
                                                    const Duration(seconds: 5),
                                                content: Text(res),
                                              ),
                                            );
                                          },
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Essentials.hexToColor(
                                                    "#707070"),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 30,
                                              width: 30,
                                              child: const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Essentials.showProgressDialog(
                                                context);
                                            final dynamic res =
                                                await Provider.of<MainProvider>(
                                                        context,
                                                        listen: false)
                                                    .acceptReqeust(
                                              a.getBids!.requests[index].id,
                                              widget.vehicleId,
                                            );
                                            Navigator.pop(context);
                                            _scaffoldKey.currentState
                                                // ignore: deprecated_member_use
                                                ?.showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 5),
                                                content: Text(res),
                                              ),
                                            );
                                          },
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Essentials.hexToColor(
                                                    "#ffc107"),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 30,
                                              width: 30,
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (a.getBids!.requests[index].requestStatus ==
                            "REJECTED") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              border: Border.all(
                                color: Essentials.hexToColor("#ffc107"),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${a.getBids!.requests[index].price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        widget.driverName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.deal_price}: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        ),
                                        Text(
                                          "${a.getBids!.requests[index].price} / Q ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(const TextStyle(
                                                color: Colors.red,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      a.getBids!.requests[index].requestStatus,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(
                                            const TextStyle(
                                              color: Colors.red,
                                            ),
                                          ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else if (a.getBids!.requests[index].requestStatus ==
                            "ACCEPTED") {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              border: Border.all(
                                color: Essentials.hexToColor("#ffc107"),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${a.getBids!.requests[index].price}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        widget.driverName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.deal_price}: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(
                                                const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                        ),
                                        Text(
                                          "${a.getBids!.requests[index].price} / Q ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(TextStyle(
                                                color: Colors.green,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      a.getBids!.requests[index].requestStatus,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(
                                            TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: Essentials.hexToColor("#ffc107")
                                .withOpacity(0.1),
                            border: Border.all(
                              color: Essentials.hexToColor("#ffc107"),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${a.getBids!.requests[index].price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .merge(
                                            const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    ),
                                    Text(
                                      widget.driverName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(
                                            const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context)!.deal_price}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .merge(
                                              const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                      ),
                                      Text(
                                        "${a.getBids!.requests[index].price} / Q ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .merge(TextStyle(
                                              color: Essentials.hexToColor(
                                                  "#ffc107"),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${a.getBids!.requests[index].requestStatus}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .merge(
                                          TextStyle(
                                            color: Essentials.hexToColor(
                                                "#ffc107"),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}

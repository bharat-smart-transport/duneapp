import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BidVehiclePage extends StatefulWidget {
  const BidVehiclePage({Key? key}) : super(key: key);

  @override
  State<BidVehiclePage> createState() => _BidVehiclePageState();
}

class _BidVehiclePageState extends State<BidVehiclePage> {
  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      backgroundColor: Essentials.hexToColor("#f5f5f5"),
      appBar: AppBar(
        backgroundColor: Essentials.hexToColor("#0390d7"),
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(AppLocalizations.of(context)!.bid_vehicle.toUpperCase()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Essentials.hexToColor("#ffc107").withOpacity(0.1),
              border: Border.all(
                color: Essentials.hexToColor("#ffc107"),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
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
                          "Vehicle Number",
                          style: Theme.of(context).textTheme.headline1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                        ),
                        Text(
                          "Driver Name",
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
                              "400Kg ",
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
                              "92 / Q ",
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
                              "Rodi ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(TextStyle(
                                    color: Essentials.hexToColor("#ffc107"),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: AssetImage('assets/Group 2072.png'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Divider(
            color: Essentials.hexToColor("#ffc107").withOpacity(0.4),
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Essentials.hexToColor("#ffc107").withOpacity(0.1),
              border: Border.all(
                color: Essentials.hexToColor("#ffc107"),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dealer's Name",
                      style: Theme.of(context).textTheme.headline1!.merge(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    ),
                    Text(
                      "Bid Price: ",
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Dealer’s Number ",
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                        ),
                        Text(
                          "Location: Meerut ",
                          style: Theme.of(context).textTheme.bodyText1!.merge(
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

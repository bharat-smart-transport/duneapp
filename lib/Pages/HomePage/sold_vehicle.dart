import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SoldVehiclePage extends StatefulWidget {
  const SoldVehiclePage({Key? key}) : super(key: key);

  @override
  State<SoldVehiclePage> createState() => _SoldVehiclePageState();
}

class _SoldVehiclePageState extends State<SoldVehiclePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        title: Text(AppLocalizations.of(context)!.sold_vehicle.toUpperCase()),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Essentials.hexToColor("#1ebf00").withOpacity(0.1),
              border: Border.all(
                color: Essentials.hexToColor("#1ebf00"),
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
                                    color: Essentials.hexToColor("#1ebf00"),
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
                                    color: Essentials.hexToColor("#1ebf00"),
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
                                    color: Essentials.hexToColor("#1ebf00"),
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
                Divider(
                  color: Essentials.hexToColor("#1ebf00"),
                  thickness: 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppLocalizations.of(context)!.buyers_details,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        fontWeight: FontWeight.w400,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.name}:              ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(const TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Text(
                      "Rodi ",
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.number}:         ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(const TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Text(
                      "Rodi ",
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      // name
                      "${AppLocalizations.of(context)!.address}:         ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .merge(const TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    Text(
                      "Rodi ",
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                FlatButton(
                  onPressed: () {},
                  color: Essentials.hexToColor("#1ebf00"),
                  child: Text(
                    AppLocalizations.of(context)!.see_location_on_map,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

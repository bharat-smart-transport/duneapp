import 'dart:io';
import 'package:dune/Pages/HomePage/add_vehicle.dart';
import 'package:dune/Pages/HomePage/empty_container.dart';
import 'package:dune/Pages/HomePage/filter_page.dart';
import 'package:dune/Pages/HomePage/loaded_container.dart';
import 'package:dune/Pages/HomePage/sold_container.dart';
import 'package:dune/Pages/side_drawer.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> showSavePopUp(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!
                      .do_you_want_to_exit_the_app),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.no.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Essentials.hexToColor("#727272"),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          exit(0);
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showSavePopUp(context),
      child: DefaultTabController(
        length: 4,
        child: Consumer<MainProvider>(
          builder: (_, a, __) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Essentials.hexToColor("#0390d7"),
                  // leading: const Icon(Icons.menu),
                  title: Text(AppLocalizations.of(context)!.my_vehicles),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.all),
                      Tab(text: AppLocalizations.of(context)!.sold),
                      Tab(text: AppLocalizations.of(context)!.loaded),
                      Tab(text: AppLocalizations.of(context)!.empty),
                    ],
                  ),
                  actions: [
                    Consumer<MainProvider>(
                      builder: (_, a, __) {
                        return a.userDetails!.data.userType == "CUSTOMER"
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FilterPage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.filter_alt,
                                ),
                              )
                            : Container();
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
                drawer: const SideDrawer(),
                body: Consumer<MainProvider>(
                  builder: (_, a, __) {
                    if (a.vehicleModel != null) {
                      if (a.vehicleModel!.data == null) {
                        return Container();
                      } else {
                        return TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: a.vehicleModel!.data.length,
                              itemBuilder: (context, index) {
                                if (a.vehicleModel!.data[index].dealStatus ==
                                    "NOT_LOADED") {
                                  return EmptyContainer(
                                    capacityUnit: a.vehicleModel!.data[index]
                                        .loadCapacityUnit
                                        .toString(),
                                    driverName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    vehicleName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    id: a.vehicleModel!.data[index].id
                                        .toString(),
                                    truckCapacity: a
                                        .vehicleModel!.data[index].loadCapacity
                                        .toString(),
                                    vehicleNo: a
                                        .vehicleModel!.data[index].vehicleNo
                                        .toString(),
                                  );
                                } else if (a
                                        .vehicleModel!.data[index].dealStatus ==
                                    "LOADED") {
                                  return LoadedContainer(
                                    truckCapacityUnit: a.vehicleModel!
                                        .data[index].loadCapacityUnit
                                        .toString(),
                                    askPrice: a
                                        .vehicleModel!.data[index].askPrice
                                        .toString(),
                                    truckMaterial: a.vehicleModel!.data[index]
                                        .materialCategory
                                        .toString(),
                                    driverName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    vehicleName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    id: a.vehicleModel!.data[index].id
                                        .toString(),
                                    truckCapacity: a
                                        .vehicleModel!.data[index].loadCapacity
                                        .toString(),
                                    vehicleNo: a
                                        .vehicleModel!.data[index].vehicleNo
                                        .toString(),
                                  );
                                } else {
                                  return SoldContainer(
                                    truckCapacityUnit: a.vehicleModel!
                                        .data[index].loadCapacityUnit
                                        .toString(),
                                    askPrice: a
                                        .vehicleModel!.data[index].askPrice
                                        .toString(),
                                    driverName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    vehicleName: a
                                        .vehicleModel!.data[index].driver!.name
                                        .toString(),
                                    id: a.vehicleModel!.data[index].id
                                        .toString(),
                                    truckCapacity: a
                                        .vehicleModel!.data[index].loadCapacity
                                        .toString(),
                                    vehicleNo: a
                                        .vehicleModel!.data[index].vehicleNo
                                        .toString(),
                                  );
                                }
                              },
                            ),
                            ListView.builder(
                              itemCount: a.sold.length,
                              itemBuilder: (context, index) {
                                if (a.sold.isEmpty) {
                                  return const Text("No Vechiles");
                                } else {
                                  return SoldContainer(
                                    truckCapacityUnit: a
                                        .sold[index].loadCapacityUnit
                                        .toString(),
                                    askPrice: a.sold[index].askPrice.toString(),
                                    driverName:
                                        a.sold[index].driver!.name.toString(),
                                    vehicleName:
                                        a.sold[index].driver!.name.toString(),
                                    id: a.sold[index].id.toString(),
                                    truckCapacity:
                                        a.sold[index].loadCapacity.toString(),
                                    vehicleNo:
                                        a.sold[index].vehicleNo.toString(),
                                  );
                                }
                              },
                            ),
                            ListView.builder(
                              itemCount: a.loaded.length,
                              itemBuilder: (context, index) {
                                if (a.loaded.isEmpty) {
                                  return const Center(
                                    child: Text("No Vehicle"),
                                  );
                                }
                                return LoadedContainer(
                                  truckMaterial: a
                                      .loaded[index].materialCategory
                                      .toString(),
                                  truckCapacityUnit: a
                                      .loaded[index].loadCapacityUnit
                                      .toString(),
                                  askPrice: a.loaded[index].askPrice.toString(),
                                  driverName:
                                      a.loaded[index].driver!.name.toString(),
                                  vehicleName:
                                      a.loaded[index].driver!.name.toString(),
                                  id: a.loaded[index].id.toString(),
                                  truckCapacity:
                                      a.loaded[index].loadCapacity.toString(),
                                  vehicleNo:
                                      a.loaded[index].vehicleNo.toString(),
                                );
                              },
                            ),
                            ListView.builder(
                              itemCount: a.empty.length,
                              itemBuilder: (context, index) {
                                if (a.empty.isEmpty) {
                                  return const Text("No Vehicles");
                                }
                                return EmptyContainer(
                                  capacityUnit: a.empty[index].loadCapacityUnit
                                      .toString(),
                                  driverName:
                                      a.empty[index].driver!.name.toString(),
                                  vehicleName:
                                      a.empty[index].driver!.name.toString(),
                                  id: a.empty[index].id.toString(),
                                  truckCapacity:
                                      a.empty[index].loadCapacity.toString(),
                                  vehicleNo:
                                      a.empty[index].vehicleNo.toString(),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    } else {
                      return const TabBarView(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                floatingActionButton: a.userDetails == null
                    ? FloatingActionButton(
                        onPressed: () {},
                        child: Container(),
                      )
                    : a.userDetails!.data.userType == "DRIVER" ||
                            a.userDetails!.data.userType == "CUSTOMER"
                        ? FloatingActionButton(
                            onPressed: () {},
                            child: Container(),
                          )
                        : FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddVehicle()));
                            },
                            child: const Icon(Icons.add),
                          ));
          },
        ),
      ),
    );
  }
}

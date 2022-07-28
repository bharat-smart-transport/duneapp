import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dune/Pages/Auth/broker.dart';
import 'package:dune/Pages/Auth/shopkeeper.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/models/login_model.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

class PickLocationShop extends StatefulWidget {
  String location;
  PickLocationShop({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  State<PickLocationShop> createState() => _PickLocationShopState();
}

class _PickLocationShopState extends State<PickLocationShop> {
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng? startLocation;
  String location1 = "";
  loc.Location currentLocation = loc.Location();

  void getLocation() async {
    loc.LocationData location = await currentLocation.getLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude!, location.longitude!);
    setState(() {
      startLocation = LatLng(location.latitude!, location.longitude!);
      location1 =
          "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
    });
  }

  @override
  void initState() {
    setState(() {
      getLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Shop Location"),
      ),
      body: startLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  //Map widget from google_maps_flutter package
                  zoomGesturesEnabled: true, //enable Zoom in, out on map
                  initialCameraPosition: CameraPosition(
                    //inital position in map
                    target: startLocation!, //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  mapType: MapType.normal, //map type
                  onMapCreated: (controller) {
                    //method called when map is created
                    setState(() {
                      mapController = controller;
                    });
                  },
                  onCameraMove: (CameraPosition cameraPositiona) {
                    cameraPosition = cameraPositiona; //when map is dragging
                  },
                  onCameraIdle: () async {
                    //when map drag stops
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude,
                    );
                    setState(() {
                      location1 =
                          "${placemarks.first.administrativeArea}, ${placemarks.first.street}";
                    });
                  },
                ),
                Center(
                  //picker image on google map
                  child: Image.asset(
                    "assets/map_point_pin.png",
                    width: 20,
                  ),
                ),
                Positioned(
                  //widget to display location name
                  bottom: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                            leading: Image.asset(
                              "assets/map_point_pin.png",
                              width: 25,
                            ),
                            title: Text(
                              location1,
                              style: const TextStyle(fontSize: 18),
                            ),
                            dense: true,
                            trailing: Consumer<MainProvider>(
                              builder: (_, a, __) {
                                return InkWell(
                                  onTap: () async {
                                    setState(() {
                                      a.location2 = location1;
                                    });
                                    if (a.userType ==
                                        "Shop_keeper".toUpperCase()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShopKeeperProfile(
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BrokerPage(
                                            location: location1,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text("Save"),
                                );
                              },
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

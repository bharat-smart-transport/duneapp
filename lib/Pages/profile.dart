import 'package:dune/Pages/side_drawer.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      backgroundColor: Essentials.hexToColor("#f5f5f5"),
      appBar: AppBar(
        backgroundColor: Essentials.hexToColor("#0390d7"),
        title: Text(AppLocalizations.of(context)!.my_profile.toUpperCase()),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 15,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!.edit),
              ],
            ),
          )
        ],
      ),
      drawer: const SideDrawer(),
      body: Consumer<MainProvider>(
        builder: (_, a, __) {
          return ListView(
            padding: EdgeInsets.all(15),
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: Image.asset(
                  "assets/Group 2072.png",
                ),
                // Image.network(
                //   a.specificVehicle!.data.image,
                //   fit: BoxFit.fill,
                //   loadingBuilder: (BuildContext context, Widget child,
                //       ImageChunkEvent? loadingProgress) {
                //     if (loadingProgress == null) return child;
                //     return Center(
                //       child: CircularProgressIndicator(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //                 loadingProgress.expectedTotalBytes!
                //             : null,
                //       ),
                //     );
                //   },
                // ),
              ),
              SizedBox(
                height: Dimension.scalePixel(20),
              ),
              TextFormField(
                initialValue: a.userDetails!.data.name ?? "",
                enabled: true,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.name,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: AppLocalizations.of(context)!.name,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: a.userDetails!.data.phone ?? "",
                enabled: true,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.number,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: AppLocalizations.of(context)!.number,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: a.userDetails!.data.email ?? "",
                enabled: true,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.email,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: AppLocalizations.of(context)!.email,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: a.userDetails!.data.address ?? "",
                enabled: true,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.address,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: AppLocalizations.of(context)!.address,
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

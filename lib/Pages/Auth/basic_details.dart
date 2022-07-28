import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:dune/models/get_owners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BasicDetails extends StatefulWidget {
  const BasicDetails({Key? key}) : super(key: key);

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? ownerId = "";
  String? ownerName = "";
  bool loading = false;

  @override
  void initState() {
    print(Provider.of<MainProvider>(context, listen: false).userType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Essentials.hexToColor("#f5f5f5"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Basic Details",
              style: Theme.of(context).textTheme.headline1!.merge(
                    TextStyle(
                      color: Essentials.hexToColor("#707070"),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
              ),
              height: 55,
              child: TextField(
                controller: name,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
              ),
              height: 55,
              child: TextField(
                controller: email,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.white,
              ),
              height: 55,
              child: TextField(
                controller: address,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<MainProvider>(
              builder: (_, a, __) {
                return a.userType == "DRIVER"
                    ? Material(
                        color: Colors.white,
                        // elevation: 1.0,
                        shadowColor: Essentials.hexToColor("#707070"),
                        child: DropdownButtonFormField(
                          hint: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Text(ownerName.toString()),
                            ],
                          ),
                          items: a.getOwner!.owners.map((Owners value) {
                            return DropdownMenuItem<Owners>(
                              value: value,
                              child: Text(value.name.toString()),
                            );
                          }).toList(),
                          onChanged: (Owners? value) {
                            ownerId = value?.id.toString();
                            ownerName = value?.name.toString();
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:
                                AppLocalizations.of(context)!.select_owner,
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  if (name.text.trim().isEmpty &&
                      email.text.trim().isEmpty &&
                      address.text.trim().isEmpty) {
                    // enter_mobile_number
                    _scaffoldKey.currentState
                        // ignore: deprecated_member_use
                        ?.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(
                            AppLocalizations.of(context)!.enter_mobile_number),
                      ),
                    );
                    setState(() {
                      loading = false;
                    });
                  } else {
                    Essentials.showProgressDialog(context);
                    if (Provider.of<MainProvider>(context, listen: false)
                            .userType ==
                        "OWNER") {
                      final String res = await Provider.of<MainProvider>(
                              context,
                              listen: false)
                          .userOwnerApi(
                        name.text.toString(),
                        email.text.toString(),
                        address.text.toString(),
                      );
                      log(res);
                      if (res == "Success") {
                        Timer(const Duration(seconds: 0), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        });
                        setState(() {
                          loading = false;
                        });
                      } else {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text("Try Again"),
                          ),
                        );
                      }
                    } else if (Provider.of<MainProvider>(context, listen: false)
                            .userType ==
                        "DRIVER") {
                      final String res = await Provider.of<MainProvider>(
                              context,
                              listen: false)
                          .userDriver(
                        name.text.toString(),
                        email.text.toString(),
                        address.text.toString(),
                        ownerId.toString(),
                      );
                      log(res);
                      if (res == "Success") {
                        Timer(const Duration(seconds: 0), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        });
                        setState(() {
                          loading = false;
                        });
                      } else {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text("Try Again"),
                          ),
                        );
                      }
                    } else {
                      _scaffoldKey.currentState
                          // ignore: deprecated_member_use
                          ?.showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text("Try Again"),
                        ),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.all(15),
                    height: Dimension.scalePixel(15),
                    width: Dimension.scalePixel(50),
                    decoration: BoxDecoration(
                      color: Essentials.hexToColor("#0390d7"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: loading == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .continuee
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .merge(
                                      const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                            ],
                          )
                        : const CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

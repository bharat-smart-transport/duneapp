import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:dune/Pages/Auth/pick_location.dart';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';

PickedFile? selfieImage;
String imagelink = "";
String selfie64 = "";

PickedFile? documentImage;
String documentlink = "";
String document64 = "";

class BrokerPage extends StatefulWidget {
  String location;
  BrokerPage({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  State<BrokerPage> createState() => _BrokerPageState();
}

class _BrokerPageState extends State<BrokerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController dharamkataname = TextEditingController();
  TextEditingController dharamkataaddress = TextEditingController();

  void _openCamera(BuildContext context, ImageSource imageSource) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: imageSource,
      imageQuality: 10,
    );
    setState(() {
      selfieImage = pickedFile!;
    });
    print("imageFile");
    imagelink = selfieImage!.path.toString();
    final bytes = Io.File(imagelink).readAsBytesSync();
    selfie64 = base64Encode(bytes);
  }

  void _openDoc(BuildContext context, ImageSource imageSource) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: imageSource,
      imageQuality: 10,
    );
    setState(() {
      documentImage = pickedFile!;
    });
    print("imageFile");
    documentlink = documentImage!.path.toString();
    final bytes = Io.File(documentlink).readAsBytesSync();
    document64 = base64Encode(bytes);
  }

  @override
  void initState() {
    selfieImage = null;
    documentImage = null;
    dharamkataaddress.text = widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Essentials.hexToColor("#f5f5f5"),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            SizedBox(
              height: Dimension.scalePixel(10),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.complete_profile_as_broker,
                style: Theme.of(context).textTheme.headline1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            selfieImage == null
                ? InkWell(
                    onTap: () {
                      _openCamera(context, ImageSource.gallery);
                    },
                    child: SizedBox(
                      height: Dimension.scalePixel(50),
                      child: SvgPicture.asset(
                        "assets/Group 5329.svg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : SizedBox(
                    height: Dimension.scalePixel(50),
                    child: Image.file(
                      Io.File(selfieImage!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: name,
              autofocus: false,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: AppLocalizations.of(context)!.enter_your_name,
                labelText: AppLocalizations.of(context)!.name,
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: mobileNumber,
              autofocus: false,
              maxLength: 10,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: AppLocalizations.of(context)!.enter_mobile_number,
                labelText: AppLocalizations.of(context)!.mobile_number,
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              leading: documentImage == null
                  ? FlatButton(
                      color: Colors.grey,
                      onPressed: () {
                        _openDoc(context, ImageSource.gallery);
                      },
                      child: Text("Choose File"),
                    )
                  : FlatButton(
                      onPressed: () {},
                      color: Colors.white,
                      child: Text("Choose File"),
                    ),
              title: documentImage == null
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      color: Colors.white,
                      child: Text("No File Chosen"))
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      color: Colors.white,
                      child: Text(
                        documentlink,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
            ),
            Divider(
              color: Essentials.hexToColor("#707070"),
              thickness: 0.8,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.dharmkata_detail,
              style: Theme.of(context).textTheme.headline1!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: dharamkataname,
              autofocus: false,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText: AppLocalizations.of(context)!.enter_dharamkata_name,
                labelText: AppLocalizations.of(context)!.name,
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              // controller: dharamkataaddress,
              initialValue: widget.location,
              enabled: false,
              autofocus: false,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Colors.grey),
                hintText:
                    AppLocalizations.of(context)!.enter_dharamkata_address,
                labelText: AppLocalizations.of(context)!.address,
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                suffixIcon: const Icon(Icons.location_city),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Essentials.hexToColor("#727272"),
                        ),
                        color:
                            Essentials.hexToColor("#727272").withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.cancel.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      if (name.text.toString().isEmpty) {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 5),
                            content:
                                Text(AppLocalizations.of(context)!.enter_name),
                          ),
                        );
                      } else if (mobileNumber.text.toString().isEmpty) {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text(AppLocalizations.of(context)!
                                .enter_mobile_number),
                          ),
                        );
                      } else if (dharamkataname.text.toString().isEmpty) {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 5),
                            content:
                                Text(AppLocalizations.of(context)!.enter_name),
                          ),
                        );
                      } else if (imagelink.toString().isEmpty) {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text(
                                AppLocalizations.of(context)!.select_image),
                          ),
                        );
                      } else if (documentlink.toString().isEmpty) {
                        _scaffoldKey.currentState
                            // ignore: deprecated_member_use
                            ?.showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text(
                                AppLocalizations.of(context)!.select_image),
                          ),
                        );
                      } else {
                        Essentials.showProgressDialog(context);
                        final String res = await Provider.of<MainProvider>(
                                context,
                                listen: false)
                            .updateProfile(
                          name.text.toString(),
                          "",
                          "",
                          mobileNumber.text.toString(),
                          "",
                          dharamkataname.text.toString(),
                          widget.location.toString(),
                          "",
                          "",
                          imagelink.toString(),
                          documentlink.toString(),
                        );
                        Navigator.pop(context);
                        if (res == "Success") {
                          Timer(const Duration(seconds: 0), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
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
                      }
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Essentials.hexToColor("#0390d7"),
                        ),
                        color:
                            Essentials.hexToColor("#0390d7").withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.submit.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

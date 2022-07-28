import 'package:dune/Pages/Auth/basic_details.dart';
import 'package:dune/Pages/Auth/broker.dart';
import 'package:dune/Pages/Auth/login.dart';
import 'package:dune/Pages/Auth/pick_location.dart';
import 'package:dune/Pages/Auth/shopkeeper.dart';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/components/button.dart';
import 'package:dune/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginAsPage extends StatefulWidget {
  const LoginAsPage({Key? key}) : super(key: key);

  @override
  State<LoginAsPage> createState() => _LoginAsPageState();
}

class _LoginAsPageState extends State<LoginAsPage> {
  int selectLang = -1;
  List<String> userType = [
    'Owner',
    'Driver',
    'Broker',
    'Shop_keeper',
  ];

  List<String> userImage = [
    'assets/registerasicons/Group 5323.png',
    'assets/registerasicons/Group 5320.png',
    'assets/registerasicons/Group 5313.png',
    'assets/registerasicons/Group 5315.png'
  ];

  String setUserType = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimension.scalePixel(20),
          ),
          Center(
            child: Text(
              AppLocalizations.of(context)!.login_as,
              style: Theme.of(context).textTheme.headline1!.merge(
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              height: Dimension.scalePixel(130),
              width: Dimension.scalePixel(80),
              child: ListView.separated(
                itemCount: userType.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        setUserType = userType[index];
                        selectLang = index;
                      });
                    },
                    child: Container(
                      width: Dimension.scalePixel(80),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectLang == index
                              ? Essentials.hexToColor("#0390d7")
                              : Essentials.hexToColor("#707070"),
                          width: 1.0,
                        ),
                        color: selectLang == index
                            ? Essentials.hexToColor("#0390d7").withOpacity(0.3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: AssetImage(
                              userImage[index],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              userType[index] == "Shop_keeper"
                                  ? "ShopKeeper"
                                  : userType[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(child: Consumer<MainProvider>(
            builder: (_, a, __) {
              return BlockButtonWidget(
                color: Essentials.hexToColor("#0390d7"),
                onPressed: () async {
                  if (setUserType.isEmpty) {
                    _scaffoldKey.currentState
                        // ignore: deprecated_member_use
                        ?.showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 5),
                        content: Text(
                          AppLocalizations.of(context)!.set_usertype,
                        ),
                      ),
                    );
                  } else {
                    Provider.of<MainProvider>(context, listen: false)
                        .setUserType(setUserType.toUpperCase());
                    print(a.loginModel!.data.name);
                    print(setUserType);
                    if (a.loginModel!.data.name == null) {
                      if (setUserType == "Broker") {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const BrokerPage()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PickLocation(
                                      title: "Enter DharamKata Address",
                                    )));
                      } else if (setUserType == "Shop_keeper") {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const ShopKeeperProfile()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PickLocation(
                                      title: "Enter DharamKata Address",
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BasicDetails()));
                      }
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  }
                },
                text: Text(
                  AppLocalizations.of(context)!.continuee.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

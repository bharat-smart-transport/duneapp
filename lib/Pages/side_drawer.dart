import 'package:dune/Pages/profile.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../prefs/shared_prefs.dart';
import 'Auth/login.dart';
import 'SelectLanguage/selectLanguage.dart';
import 'Wallet/add_moeny.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<MainProvider>(
        builder: (_, a, __) {
          return a.userDetails == null
              ? Container()
              : ListView(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      backgroundColor: const Color(0xFF778899),
                      child: Image.asset(
                        'assets/splash_screen.png',
                        fit: BoxFit.contain,
                      ), //For Image Asset
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "${a.userDetails!.data.name}".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .merge(TextStyle(
                              color: Essentials.hexToColor("#707070"),
                            )),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Essentials.hexToColor("#0390d7"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Essentials.hexToColor("#0390d7"),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.add_vehicle,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Essentials.hexToColor("#0390d7"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddMoney()));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Essentials.hexToColor("#0390d7"),
                              child: const Icon(
                                Icons.wallet,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.wallet_money,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Essentials.hexToColor("#0390d7"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectLanguageSetting()));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Essentials.hexToColor("#0390d7"),
                              child: const Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.select_language,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Essentials.hexToColor("#0390d7"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        onTap: () async {
                          SharedPrefs.removeUser();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Essentials.hexToColor("#0390d7"),
                              child: const Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.profile,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Essentials.hexToColor("#0390d7"),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        onTap: () async {
                          SharedPrefs.removeUser();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Essentials.hexToColor("#0390d7"),
                              child: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              AppLocalizations.of(context)!.logout,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
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

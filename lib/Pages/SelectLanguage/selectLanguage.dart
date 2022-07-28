import 'dart:io';

import 'package:dune/Pages/Auth/login.dart';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:dune/main.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguageSetting extends StatefulWidget {
  const SelectLanguageSetting({Key? key}) : super(key: key);

  @override
  State<SelectLanguageSetting> createState() => _SelectLanguageSettingState();
}

class _SelectLanguageSettingState extends State<SelectLanguageSetting> {
  final ScrollController _sController = ScrollController();

  List<String> images = [
    "assets/english.svg",
    "assets/hindi.svg",
  ];

  List<String> text1 = [
    "English",
    "Hindi",
  ];
  List<String> text2 = [
    "English",
    "हिंदी",
  ];

  List<String> lang = [
    'en',
    'hi',
  ];

  int selectLang = -1;
  String langCode = "";

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.select_language,
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _sController,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    print(lang[index]);
                    setState(() {
                      selectLang = index;
                      langCode = lang[index];
                    });
                    print(langCode);
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectLang == index
                                ? Essentials.hexToColor("#0390d7")
                                : Essentials.hexToColor("#707070"),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              images[index],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  text2[index],
                                  style: TextStyle(
                                    color: selectLang == index
                                        ? Essentials.hexToColor("#0390d7")
                                        : Essentials.hexToColor("#707070"),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  text1[index],
                                  style: TextStyle(
                                    color: selectLang == index
                                        ? Essentials.hexToColor("#0390d7")
                                        : Essentials.hexToColor("#707070"),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
                SharedPrefs.setLang(langCode);
                MyApp.of(context).setLocale(
                  Locale.fromSubtags(
                    languageCode: langCode,
                  ),
                );
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.continuee.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1!.merge(
                            const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

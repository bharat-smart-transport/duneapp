import 'package:dune/Provider/main_provider.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:dune/route_gen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {  

  Locale? _locale;

  void setLocale(Locale value) async {
    setState(() {
      _locale = value;
    });
  }

  void setAccessToken() async {
    String lang = await SharedPrefs.getData("lang");
    Locale forcedLocale = lang.isNotEmpty ? Locale(lang) : const Locale("hi");
    setState(() {
      _locale = forcedLocale;
    });
  }

  @override
  void initState() {
    setAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      child: MaterialApp(
        title: 'Dune',
        initialRoute: '/',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          hintColor: const Color(0xFF000000),
          focusColor: const Color(0xFFF4F4F4),
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 26,
              wordSpacing: 2,
              fontWeight: FontWeight.w600,
              color: Color(0xff3dbeff),
            ),
            headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            headline3: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            headline4: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            headline6: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff77A400)),
            bodyText2: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: Color(0xff7D7D7D)),
            bodyText1: TextStyle(
                fontSize: 12.0,
                color: Color(0xff7F7F7F),
                fontWeight: FontWeight.w600),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF3dbeff),
            secondary: const Color(0xFF3dbeff),
          ),
        ),
        theme: ThemeData(
          // primaryColor: const Color(0xFF3dbeff),
          scaffoldBackgroundColor: Colors.white,
          hintColor: const Color(0xFF000000),
          focusColor: const Color(0xFFF4F4F4),
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 26,
              wordSpacing: 2,
              fontWeight: FontWeight.w600,
              color: Color(0xff3dbeff),
            ),
            headline2: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            headline3: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            headline4: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.white),
            headline6: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff77A400)),
            bodyText2: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              color: Color(0xff7D7D7D),
            ),
            bodyText1: TextStyle(
                fontSize: 15,
                color: Color(0xff7F7F7F),
                fontWeight: FontWeight.w600),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color(0xFF3dbeff),
              secondary: const Color(0xFF3dbeff)),
        ),
      ),
    );
  }
}

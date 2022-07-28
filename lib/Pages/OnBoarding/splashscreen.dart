import 'package:dune/Pages/SelectLanguage/select_language.dart';
import 'package:dune/Services/essentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        scrollPhysics: const BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            title: "",
            bodyWidget: Container(),
            reverse: true,
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    "assets/splash.svg",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Heading",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        fontSize: 20,
                      )),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Container(),
            reverse: true,
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/splash2.png",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Heading 2",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        fontSize: 20,
                      )),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          PageViewModel(
            title: "",
            bodyWidget: Container(),
            reverse: true,
            footer: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/splash3.png",
                    height: 200,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Heading 3",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(
                        fontSize: 20,
                      )),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
        onChange: (e) {
          // When something changes
        },
        onDone: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Selectlanguage()));
        },
        onSkip: () {
          // You can also override onSkip callback
        },
        next: CircleAvatar(
          backgroundColor: Essentials.hexToColor("#0390d7"),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
        ),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}

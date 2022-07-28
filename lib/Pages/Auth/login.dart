// ignore_for_file: avoid_print

import 'package:dune/Pages/Auth/verification.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  String? _status;

  AuthCredential? _phoneAuthCredential;
  String? _verificationId;
  int? _code;
  @override
  void dispose() {
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
      _simCard = (await MobileNumber.getSimCards)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
      print("----------------------");
      print(mobileNumber);
    });
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  bool isLoading = false;
  String? verificationId;

  String _phone = "";
  final TextEditingController _smsCode = TextEditingController();

  bool _otp = false;
  Future<void> verifyPhone() async {
    print("object");
    setState(() {
      isLoading = true;
    });
    Essentials.showProgressDialog(context);
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      _verificationId = verId;
      setState(() {
        isLoading = false;
      });
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      _verificationId = verId;

      print('codeSent');
      _verificationId = verificationId;

      setState(() {
        _status = 'Code Sent\n';
        verificationId = verId;
        isLoading = false;
      });
      print(verificationId);
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Verification(
            phoneNumberWithoutCode:
                "91" + mobileNumberController.text.toString().trim(),
            num: "+91" + mobileNumberController.text.toString().trim(),
            verificationId: verificationId.toString(),
          ),
        ),
      );
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verifiedSuccess =
        (phoneAuthCredential) async {
      print('verificationCompleted');
      setState(() {
        _status = 'verificationCompleted\n';
        _phoneAuthCredential = phoneAuthCredential;
      });
      print(phoneAuthCredential);
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      Navigator.pop(context);
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          content: Text(
              "Something went wrong, check your internet connection or verify phone number again!")));
      print('${exception.message}');
      setState(() {
        isLoading = false;
      });
    };

    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + mobileNumberController.text.toString().trim(),
      codeAutoRetrievalTimeout: autoRetrieve,
      codeSent: smsCodeSent,
      timeout: const Duration(seconds: 120),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verificationFailed,
    );
  }

  @override
  Widget build(BuildContext context) {
    Dimension.init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Essentials.hexToColor("#f5f5f5"),
        key: _scaffoldKey,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Image.asset("assets/loginBackground.png"),
            ),
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: _mobileNumber.isEmpty
                              // ? PhoneFieldHint(
                              //     controller: mobileNumberController,
                              //     inputFormatters: <TextInputFormatter>[
                              //       FilteringTextInputFormatter.digitsOnly
                              //     ],
                              //     decoration: InputDecoration(
                              //       hintText: AppLocalizations.of(context)!
                              //           .enter_mobile_number
                              //           .toUpperCase(),
                              //       contentPadding: const EdgeInsets.all(15),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(30),
                              //       ),
                              //     ),
                              //   )
                              ? TextFormField(
                                  maxLength: 10,
                                  controller: mobileNumberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    hintText: AppLocalizations.of(context)!
                                        .enter_mobile_number
                                        .toUpperCase(),
                                    contentPadding: const EdgeInsets.all(15),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                )
                              : fillCards(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (mobileNumberController.text.trim().isEmpty) {
                            // enter_mobile_number
                            _scaffoldKey.currentState
                                // ignore: deprecated_member_use
                                ?.showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text(AppLocalizations.of(context)!
                                    .enter_mobile_number),
                              ),
                            );
                          } else {
                            verifyPhone();
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            margin: const EdgeInsets.all(15),
                            height: Dimension.scalePixel(15),
                            decoration: BoxDecoration(
                              color: Essentials.hexToColor("#0390d7"),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
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
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                                .by_continuing_you_agree_to +
                            " ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .merge(const TextStyle(
                              fontWeight: FontWeight.w300,
                            )),
                      ),
                      Text(
                        AppLocalizations.of(context)!.terms_and_condition,
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

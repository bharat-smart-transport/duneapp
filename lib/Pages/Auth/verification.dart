import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:dune/Pages/Auth/basic_details.dart';
import 'package:dune/Pages/Auth/login.dart';
import 'package:dune/Pages/Auth/login_as_page.dart';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/config.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Verification extends StatefulWidget {
  String? num;
  String? phoneNumberWithoutCode;
  String? verificationId;
  Verification({
    Key? key,
    this.num,
    this.phoneNumberWithoutCode,
    this.verificationId,
  }) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String signature = "{{ app signature }}";
  String? appSignature;
  String? otpCode;

  @override
  void initState() {
    // getSignature();
    textEditingController1 = TextEditingController();
    initSmsListener();
    super.initState();
  }

  TextEditingController textEditingController1 = TextEditingController();

  String _comingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms!;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[32]}");
      textEditingController1.text = _comingSms[0] +
          _comingSms[1] +
          _comingSms[2] +
          _comingSms[3] +
          _comingSms[4] +
          _comingSms[5];
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  void getSignature() async {
    signature = await SmsAutoFill().getAppSignature;
    setState(() {
      print(signature);
    });
  }

  bool isLoading = false;
  void signIn(String pin) async {
    setState(() {
      isLoading = true;
    });
    Essentials.showProgressDialog(context);
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId!,
      smsCode: pin,
    );
    signInWithCredential(credential);
  }

  void signInWithCredential(AuthCredential credential) async {
    try {
      final auth = await _auth.signInWithCredential(credential);
      final a = Provider.of<MainProvider>(context, listen: false);
      if (auth.user != null) {
        print(auth.user!.uid.toString());

        final String res =
            await Provider.of<MainProvider>(context, listen: false).login(
          auth.user!.uid.toString(),
          widget.phoneNumberWithoutCode.toString(),
        );
        print("900000000000000000000");
        print(res);
        Navigator.pop(context);
        if (res == "Login") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else if (res == "Register") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginAsPage()));
        }
      } else {
        // ignore: deprecated_member_use
        _scaffoldKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Sign In failed! Try again"),
            duration: Duration(seconds: 2)));
        setState(() {
          isLoading = false;
        });
      }
    } catch (er) {
      print(er);
      // ignore: deprecated_member_use
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
        content: Text("You have entered wrong OTP"),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        isLoading = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Essentials.hexToColor("#f5f5f5"),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset("assets/verificationBackground.png"),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimension.scalePixel(20),
                    ),
                    Text(
                      AppLocalizations.of(context)!.verification,
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .merge(const TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    SizedBox(
                      height: Dimension.scalePixel(5),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .please_enter_the_verification_code,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      AppLocalizations.of(context)!.sent_to +
                          " " +
                          widget.num.toString(),
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: Dimension.scalePixel(5),
                    ),
                    // OTPTextField(
                    //   length: 6,
                    //   margin: const EdgeInsets.symmetric(horizontal: 0.3),
                    //   width: MediaQuery.of(context).size.width,
                    //   fieldWidth: 50,
                    //   style: const TextStyle(fontSize: 17),
                    //   textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    //   fieldStyle: FieldStyle.underline,
                    //   onCompleted: (pin) {
                    //     print("Completed: " + pin);
                    //     signIn(pin);
                    //   },
                    // ),
                    // PinFieldAutoFill(
                    //   codeLength: 6,
                    //   decoration: UnderlineDecoration(
                    //     textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    //     colorBuilder:
                    //         FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    //   ),
                    //   onCodeSubmitted: (code) {
                    //     print("Completed: " + code);
                    //     signIn(code);
                    //   },
                    //   onCodeChanged: (code) {
                    //     if (code!.length == 6) {
                    //       FocusScope.of(context).requestFocus(FocusNode());
                    //     }
                    //   },
                    // ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          inactiveFillColor: Colors.white,
                          inactiveColor: Colors.black,
                          selectedColor: Colors.black,
                          selectedFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          activeColor: Colors.black,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        controller: textEditingController1,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {
                          print("Completed: " + v);
                          signIn(v);
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            print('$value');
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.didnt_receive_code,
                              style:
                                  Theme.of(context).textTheme.headline2!.merge(
                                        const TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                      AppLocalizations.of(context)!.verify.toUpperCase(),
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
            ],
          ),
        ],
      ),
    );
  }
}

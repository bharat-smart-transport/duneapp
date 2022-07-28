import 'package:dune/Services/essentials.dart';
import 'package:dune/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  TextEditingController money = TextEditingController();
  Razorpay _razorpay = Razorpay();
  String? oid;
  String checksum = '';
  int max_bonus = 0;
  bool loading = true;
  final GlobalKey<ScaffoldState> _myGlobe = GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _razorpay.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    max_bonus = 0;
    oid = DateTime.now().millisecondsSinceEpoch.toString();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print(response.paymentId.toString());
  }

  // String payment_response = null;

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      print("++++++++++++++++++++++++++++++++++++++++++++");
      print(response.message);
      setState(() {
        loading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Essentials.hexToColor("#0390d7"),
        // leading: const Icon(Icons.menu),
        title: Text(AppLocalizations.of(context)!.add_money),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Text(
                "Balance:      ",
                style: Theme.of(context).textTheme.bodyText1!.merge(
                      const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ),
              Text(
                "1500",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .merge(const TextStyle(
                      fontSize: 20,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: money,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            autofocus: false,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: AppLocalizations.of(context)!.add_money,
              labelText: AppLocalizations.of(context)!.enter_amount,
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlockButtonWidget(
                color: Colors.grey,
                onPressed: () {},
                text: Text(AppLocalizations.of(context)!.cancel.toUpperCase()),
              ),
              const SizedBox(
                width: 15,
              ),
              BlockButtonWidget(
                color: Essentials.hexToColor("#0390d7"),
                onPressed: () async {
                  if (money.text.isEmpty) {
                    return;
                  } else {
                    _razorpay.open(
                      {
                        'key': 'rzp_test_nzysic8orYRdIc',
                        'amount': (double.parse(money.text.trim()) * 100)
                            .toInt()
                            .toString(),
                        'name': 'City Knockz',
                        'theme.color': "#0390d7",
                        'buttontext': "Pay with Razorpay",
                        'description': 'DuneApp',
                        'prefill': {
                          'contact': '1234567891',
                          'email': 'abc@gmail.com',
                        }
                      },
                    );
                  }
                },
                text:
                    Text(AppLocalizations.of(context)!.add_money.toUpperCase()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

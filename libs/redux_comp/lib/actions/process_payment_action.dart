import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

class ProcessPaymentAction extends ReduxAction<AppState> {
  final BuildContext context;

  ProcessPaymentAction(this.context);

  @override
  Future<AppState?> reduce() async {
    PaystackPlugin paystackPlugin = PaystackPlugin();

    paystackPlugin.initialize(
      publicKey: "pk_test_baaa336322aaf8057d0e5827c21b3cbb96d0bcdb",
    );

    // testing
    Charge charge = Charge()
      ..amount = 10000
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
//..accessCode = _createAcessCode(skTest, _getReference())
      ..email = 'mdp0101@gmail.com';
    CheckoutResponse response = await paystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      _verifyOnServer(response.reference);
    } else {
      //show error
    }
  }
}

Future<String> createAccessCode() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer sk_test_8193004a99ab1e7bf93ace9b03abb738d776281e'
  };

  Map data = {
    "amount": 600,
    "email": "cachemoney.up@gmail.com",
    "reference": DateTime.now().millisecondsSinceEpoch.toString(),
  };

  String payload = json.encode(data);
  http.Response response = await http.post(
    Uri.parse("https://api.paystack.co/transaction/initialize"),
    headers: headers,
    body: payload,
  );

  final Map d = jsonDecode(response.body);
  String accessCode = d['data']['access_code'];

  return accessCode;
}

void _verifyOnServer(String? reference) async {
  try {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':
          'Bearer sk_test_8193004a99ab1e7bf93ace9b03abb738d776281e',
    };
    http.Response response = await http.get(
      Uri.parse('https://api.paystack.co/transaction/verify/$reference'),
      headers: headers,
    );
    final Map body = json.decode(response.body);
    if (body['data']['status'] == 'success') {
      //do something with the response. show success
      print("success");
    } else {
      //show error prompt
      print("fail");
    }
  } catch (e) {
    print(e);
  }
}

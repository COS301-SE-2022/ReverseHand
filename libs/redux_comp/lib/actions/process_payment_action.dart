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

    await paystackPlugin.initialize(
      publicKey: state.paystackPublicKey,
    );

    // testing
    Charge charge = Charge()
      ..amount = 600
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
      // ..accessCode = await createAccessCode()
      ..currency = 'ZAR'
      ..email = 'mdp0101@gmail.com';

    // ignore: use_build_context_synchronously
    CheckoutResponse response = await paystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.status) {
      _verifyOnServer(response.reference);
    } else {
      //show error
    }

    return null;
  }

  Future<String> createAccessCode() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${state.paystackSecretKey}'
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
        'Authorization': 'Bearer ${state.paystackSecretKey}',
      };
      http.Response response = await http.get(
        Uri.parse('https://api.paystack.co/transaction/verify/$reference'),
        headers: headers,
      );
      final Map body = json.decode(response.body);
      if (body['data']['status'] == 'success') {
        //do something with the response. show success
        // print("success");
      } else {
        //show error prompt
        // print("fail");
      }
    } catch (e) {
      // print(e);
    }
  }
}

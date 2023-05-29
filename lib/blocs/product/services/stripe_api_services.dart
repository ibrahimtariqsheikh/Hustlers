import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../.env';

class StripeApiServices {
  createPaymentIntent(int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toString(),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $PRIVATE_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      print('ERROR-------------------------- $err');
      throw Exception(err.toString());
    }
  }
}

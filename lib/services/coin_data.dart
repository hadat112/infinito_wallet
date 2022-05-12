import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'USD',
  'EUR',
  // 'GBP',
  // 'SGD',
  // 'AUD',
  // 'BRL',
  // 'CAD',
  // 'CNY',
  // 'HKD',
  // 'IDR',
  // 'ILS',
  // 'INR',
  // 'JPY',
  // 'MXN',
  // 'NOK',
  // 'NZD',
  // 'PLN',
  // 'RON',
  // 'RUB',
  // 'SEK',
  // 'ZAR',
  // 'VND'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  // 'LTC',
  // 'ADA',
];

const bitcoinAverageURL =
    'https://api.gemini.com/v1/pubticker';

class CoinData {
  Future<Map<String, String>> getCoinData(String crypto) async {
    final Map<String, String> cryptoPrices = {};
    for (String currency in currenciesList) {
      String url = '$bitcoinAverageURL/${crypto}${currency}';
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['last'];
        cryptoPrices[currency] = data.toString();
      } else {
        print(response.statusCode);
        throw 'ther is a broblem wihle fetching data from api';
      }
    }
    return cryptoPrices;
  }
}
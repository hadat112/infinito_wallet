import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'USD',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'ZAR',
  'VND'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'ADA',
];

const bitcoinAverageURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {
  Future<Map<String, String>> getCoinData(String selectedCurrency) async {
    final Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String url = '$bitcoinAverageURL/$crypto$selectedCurrency';
      http.Response response = await http.get(Uri.parse('$bitcoinAverageURL/$crypto$selectedCurrency'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['last'];
        cryptoPrices[crypto] = data.toString();
      } else {
        print(response.statusCode);
        throw 'ther is a broblem wihle fetching data from api';
      }
    }
    return cryptoPrices;
  }
}
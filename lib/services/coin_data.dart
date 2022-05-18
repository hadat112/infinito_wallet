import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/coin_model.dart';

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

const bitcoinAverageURL = 'https://api.gemini.com/v1/pubticker';

class CoinData {
  Future<Map<String, String>> getCoinData(String crypto) async {
    final Map<String, String> cryptoPrices = {};
    for (final String currency in currenciesList) {
      final String url = '$bitcoinAverageURL/$crypto$currency';
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['last'];
        cryptoPrices[currency] = data.toString();
      } else {
        final Error error =
            ArgumentError('ther is a broblem wihle fetching data from api');

        // print(response.statusCode);
        throw error;
      }
    }
    return cryptoPrices;
  }

  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            final Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }
}

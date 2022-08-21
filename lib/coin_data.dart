import 'package:flutter/material.dart';

import 'NetworkHelper.dart';
import 'price_screen.dart';

const apiKey = '30815EC2-F029-4BAC-9D9D-F865E70480B1';

// https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1

const List<String> currenciesList = [
  'USD',
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
  'SAR',
  'SEK',
  'SGD',
  'AUD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
String curr;

class CoinDataModel {
  CoinDataModel();
  void setCurr(String currency) {
    curr = currency;
  }

  Uri coinApiUrl = Uri.https('api.coingecko.com', '/api/v3/coins/markets', {
    'vs_currency': '$curr',
  });

  Future<dynamic> getCoinData() async {
    NetworkHelper networkHelper = NetworkHelper(coinApiUrl);
    var coinData = await networkHelper.getData();
    return coinData;
  }
}

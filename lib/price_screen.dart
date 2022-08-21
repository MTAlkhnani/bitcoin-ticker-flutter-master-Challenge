import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

String selectedCurrency = 'Choose The Currency';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinDataModel coinDataModel = CoinDataModel();
  String btcPrice = '';
  String ethPrice = '';
  String adaPrice = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //updateUI();
  }

  void updateUI() async {
    CoinDataModel coinDataModel = CoinDataModel();
    var coinData = await coinDataModel.getCoinData();
    setState(() {
      if (coinData != null) {
        btcPrice = coinData[0]['current_price'].toString();
        ethPrice = coinData[1]['current_price'].toString();
        adaPrice = coinData[7]['current_price'].toString();
      } else {
        //print(coinData[0]['current_price'].toString());
        btcPrice = '0';
      }
    });
  }

// 0.symbol
//0.current_price
  //Variables

  //Methods
  CupertinoPicker iosCurrPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: ((index) {
        selectedCurrency = currenciesList[index];
        coinDataModel.setCurr(selectedCurrency);
        updateUI();
      }),
      children: currenciesList
          .map((currency) => Text(
                currency,
                style: TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  DropdownButton<String> androidCurrPicker() {
    selectedCurrency = 'USD';
    return DropdownButton<String>(
        value: selectedCurrency,
        items: currenciesList
            .map((currency) => DropdownMenuItem(
                  child: Text(
                    currency,
                  ),
                  value: currency,
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            coinDataModel.setCurr(selectedCurrency);
            //print(selectedCurrency);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $btcPrice $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ethPrice $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ADA = $adaPrice $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosCurrPicker() : androidCurrPicker(),
          ),
        ],
      ),
    );
  }
}

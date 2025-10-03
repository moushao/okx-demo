import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okx_demo/main_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../model/ticker.dart';

class SpotList extends StatefulWidget {
  const SpotList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SpotList();
  }
}

class _SpotList extends State<SpotList> {
  @override
  Widget build(BuildContext context) {
    var tickers = context.read<MainViewModel>().tickers;
    return ListView.builder(
      itemCount: tickers.length,
      itemBuilder: (context, index) {
        final ticker = tickers[index];

        Decimal currentPrice = Decimal.parse(ticker.last);
        Decimal openPrice = Decimal.parse(ticker.open24h);

        bool isPositive = currentPrice > openPrice;
        Decimal change = currentPrice - openPrice;
        String changePercentStr = (change / openPrice).toString();

        final changeColor = isPositive ? Colors.green : Colors.red;

        final parts = ticker.instId.split('-');
        final baseCurrency = parts.isNotEmpty ? parts[0] : '';
        final quoteCurrency = parts.length > 1 ? parts[1] : '';

        Color iconColor = _getCurrencyColor(baseCurrency);

        String formattedVolume = ticker.volCcy24h;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: iconColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          baseCurrency.isNotEmpty
                              ? baseCurrency.substring(0, 1)
                              : '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                baseCurrency,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                ' / $quoteCurrency',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              if (_shouldShowLeverage(baseCurrency)) ...[
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '10x',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$$formattedVolume',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            Ticker.formatPrice(ticker.last),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${Ticker.formatPrice(ticker.open24h)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 34,
                        width: 78,
                        decoration: BoxDecoration(
                          color: changeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '${isPositive ? '+' : ''}$changePercentStr%',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getCurrencyColor(String currency) {
    int seed = currency.codeUnits.fold(0, (prev, element) => prev + element);
    Random random = Random(seed);

    List<Color> colors = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.yellow,
      Colors.lime,
      Colors.green,
      Colors.teal,
      Colors.cyan,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.grey,
    ];

    return colors[random.nextInt(colors.length)];
  }

  bool _shouldShowLeverage(String currency) {
    return ['BTC', 'ETH', 'DOGE'].contains(currency.toUpperCase());
  }
}

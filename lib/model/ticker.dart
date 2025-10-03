/*{
"instType": "SPOT",
"instId": "ILV-USD",
"last": "16.117",
"lastSz": "0.735385",
"askPx": "16.149",
"askSz": "18.577001",
"bidPx": "15.965",
"bidSz": "0.742397",
"open24h": "12.885",
"high24h": "16.117",
"low24h": "12.885",
"volCcy24h": "2082.743160374",
"vol24h": "136.314571",
"ts": "1759408543345",
"sodUtc0": "14.218",
"sodUtc8": "14.218"
}*/




class Ticker {
  Ticker({
    required String instType,
    required String instId,
    required String last,
    required String lastSz,
    required String askPx,
    required String askSz,
    required String bidPx,
    required String bidSz,
    required String open24h,
    required String high24h,
    required String low24h,
    required String volCcy24h,
    required String vol24h,
    required String ts,
    required String sodUtc0,
    required String sodUtc8,
  }) {
    _instType = instType;
    _instId = instId;
    _last = last;
    _lastSz = lastSz;
    _askPx = askPx;
    _askSz = askSz;
    _bidPx = bidPx;
    _bidSz = bidSz;
    _open24h = open24h;
    _high24h = high24h;
    _low24h = low24h;
    _volCcy24h = volCcy24h;
    _vol24h = vol24h;
    _ts = ts;
    _sodUtc0 = sodUtc0;
    _sodUtc8 = sodUtc8;
  }


  /// 静态方法：从JSON数组创建Ticker列表
  static List<Ticker> fromJsonToList(dynamic json) {
    List<Ticker> data = <Ticker>[];
    if (json != null && json is List) {
      for (var item in json) {
        data.add(Ticker.fromJson(item));
      }
    }
    return data;
  }

  /// 静态方法：从API响应创建Ticker列表
  static List<Ticker> fromApiResponse(dynamic response) {
    if (response != null && 
        response['code'] == '0' && 
        response['data'] != null) {
      return fromJsonToList(response['data']);
    }
    return [];
  }

  /// 静态方法：计算涨跌幅
  static double calculateChangePercent(String last, String open24h) {
    double lastPrice = double.tryParse(last) ?? 0;
    double openPrice = double.tryParse(open24h) ?? 0;
    
    if (openPrice == 0) return 0;
    return ((lastPrice - openPrice) / openPrice) * 100;
  }

  /// 静态方法：格式化价格显示
  static String formatPrice(String price) {
    double value = double.tryParse(price) ?? 0;
    if (value >= 1) {
      return value.toStringAsFixed(2);
    } else if (value >= 0.01) {
      return value.toStringAsFixed(4);
    } else {
      return value.toStringAsFixed(8);
    }
  }

  /// 静态方法：格式化成交量显示
  static String formatVolume(String volume) {
    double value = double.tryParse(volume) ?? 0;
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  Ticker.fromJson(dynamic json) {
    _instType = json['instType'];
    _instId = json['instId'];
    _last = json['last'];
    _lastSz = json['lastSz'];
    _askPx = json['askPx'];
    _askSz = json['askSz'];
    _bidPx = json['bidPx'];
    _bidSz = json['bidSz'];
    _open24h = json['open24h'];
    _high24h = json['high24h'];
    _low24h = json['low24h'];
    _volCcy24h = json['volCcy24h'];
    _vol24h = json['vol24h'];
    _ts = json['ts'];
    _sodUtc0 = json['sodUtc0'];
    _sodUtc8 = json['sodUtc8'];
  }
  String _instType = '';
  String _instId = '';
  String _last = '';
  String _lastSz = '';
  String _askPx = '';
  String _askSz = '';
  String _bidPx = '';
  String _bidSz = '';
  String _open24h = '';
  String _high24h = '';
  String _low24h = '';
  String _volCcy24h = '';
  String _vol24h = '';
  String _ts = '';
  String _sodUtc0 = '';
  String _sodUtc8 = '';

  Ticker copyWith({
    String? instType,
    String? instId,
    String? last,
    String? lastSz,
    String? askPx,
    String? askSz,
    String? bidPx,
    String? bidSz,
    String? open24h,
    String? high24h,
    String? low24h,
    String? volCcy24h,
    String? vol24h,
    String? ts,
    String? sodUtc0,
    String? sodUtc8,
  }) => Ticker(
    instType: instType ?? _instType,
    instId: instId ?? _instId,
    last: last ?? _last,
    lastSz: lastSz ?? _lastSz,
    askPx: askPx ?? _askPx,
    askSz: askSz ?? _askSz,
    bidPx: bidPx ?? _bidPx,
    bidSz: bidSz ?? _bidSz,
    open24h: open24h ?? _open24h,
    high24h: high24h ?? _high24h,
    low24h: low24h ?? _low24h,
    volCcy24h: volCcy24h ?? _volCcy24h,
    vol24h: vol24h ?? _vol24h,
    ts: ts ?? _ts,
    sodUtc0: sodUtc0 ?? _sodUtc0,
    sodUtc8: sodUtc8 ?? _sodUtc8,
  );
  String get instType => _instType;
  String get instId => _instId;
  String get last => _last;
  String get lastSz => _lastSz;
  String get askPx => _askPx;
  String get askSz => _askSz;
  String get bidPx => _bidPx;
  String get bidSz => _bidSz;
  String get open24h => _open24h;
  String get high24h => _high24h;
  String get low24h => _low24h;
  String get volCcy24h => _volCcy24h;
  String get vol24h => _vol24h;
  String get ts => _ts;
  String get sodUtc0 => _sodUtc0;
  String get sodUtc8 => _sodUtc8;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['instType'] = _instType;
    map['instId'] = _instId;
    map['last'] = _last;
    map['lastSz'] = _lastSz;
    map['askPx'] = _askPx;
    map['askSz'] = _askSz;
    map['bidPx'] = _bidPx;
    map['bidSz'] = _bidSz;
    map['open24h'] = _open24h;
    map['high24h'] = _high24h;
    map['low24h'] = _low24h;
    map['volCcy24h'] = _volCcy24h;
    map['vol24h'] = _vol24h;
    map['ts'] = _ts;
    map['sodUtc0'] = _sodUtc0;
    map['sodUtc8'] = _sodUtc8;
    return map;
  }

}

class MarketDataProcessor {
  /// 处理市场数据，生成不同类型的榜单
  static Map<String, List<Map<String, dynamic>>> processMarketData(
      List<dynamic> rawData) {
    
    // 转换数据格式并计算涨跌幅
    List<Map<String, dynamic>> processedData = rawData.map((item) {
      double last = double.tryParse(item['last'] ?? '0') ?? 0;
      double open24h = double.tryParse(item['open24h'] ?? '0') ?? 0;
      double vol24h = double.tryParse(item['vol24h'] ?? '0') ?? 0;
      double volCcy24h = double.tryParse(item['volCcy24h'] ?? '0') ?? 0;
      
      // 计算涨跌幅
      double changePercent = 0;
      if (open24h > 0) {
        changePercent = ((last - open24h) / open24h) * 100;
      }
      
      return {
        'instId': item['instId'],
        'last': last,
        'open24h': open24h,
        'high24h': double.tryParse(item['high24h'] ?? '0') ?? 0,
        'low24h': double.tryParse(item['low24h'] ?? '0') ?? 0,
        'vol24h': vol24h,
        'volCcy24h': volCcy24h,
        'changePercent': changePercent,
        'ts': item['ts'],
      };
    }).toList();

    return {
      'hot': _getHotList(processedData),      // 热门榜：按成交量排序
      'gainers': _getGainersList(processedData), // 涨幅榜：按涨幅排序
      'losers': _getLosersList(processedData),   // 跌幅榜：按跌幅排序
      'new': _getNewList(processedData),      // 新币榜：按时间戳排序
    };
  }

  /// 热门榜：按24小时成交量排序
  static List<Map<String, dynamic>> _getHotList(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> sorted = List.from(data);
    sorted.sort((a, b) => b['volCcy24h'].compareTo(a['volCcy24h']));
    return sorted.take(50).toList(); // 取前50个
  }

  /// 涨幅榜：按涨幅排序
  static List<Map<String, dynamic>> _getGainersList(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> sorted = List.from(data);
    sorted.sort((a, b) => b['changePercent'].compareTo(a['changePercent']));
    return sorted.take(50).toList(); // 取前50个
  }

  /// 跌幅榜：按跌幅排序
  static List<Map<String, dynamic>> _getLosersList(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> sorted = List.from(data);
    sorted.sort((a, b) => a['changePercent'].compareTo(b['changePercent']));
    return sorted.take(50).toList(); // 取前50个
  }

  /// 新币榜：按时间戳排序（假设时间戳越大越新）
  static List<Map<String, dynamic>> _getNewList(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> sorted = List.from(data);
    sorted.sort((a, b) => b['ts'].compareTo(a['ts']));
    return sorted.take(50).toList(); // 取前50个
  }

  /// 格式化价格显示
  static String formatPrice(double price) {
    if (price >= 1) {
      return price.toStringAsFixed(2);
    } else if (price >= 0.01) {
      return price.toStringAsFixed(4);
    } else {
      return price.toStringAsFixed(8);
    }
  }

  /// 格式化涨跌幅显示
  static String formatChangePercent(double percent) {
    String sign = percent >= 0 ? '+' : '';
    return '$sign${percent.toStringAsFixed(2)}%';
  }

  /// 格式化成交量显示
  static String formatVolume(double volume) {
    if (volume >= 1000000000) {
      return '${(volume / 1000000000).toStringAsFixed(1)}B';
    } else if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    } else {
      return volume.toStringAsFixed(0);
    }
  }
}

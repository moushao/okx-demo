import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class SpotBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SpotBar();
  }

}

class _SpotBar extends State<SpotBar>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        labelPadding: EdgeInsets.symmetric(horizontal: 12),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: RectangularIndicator(
          color: Colors.blue.shade100,
          verticalPadding: 8,
          horizontalPadding: 1,
          bottomLeftRadius: 20,
          bottomRightRadius: 20,
          topLeftRadius: 20,
          topRightRadius: 20,
          paintingStyle: PaintingStyle.fill,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.3,
        ),
        tabs: [
          Tab(text: "热门榜"),
          Tab(text: "涨幅榜"),
          Tab(text: "新币榜"),
        ],
        labelColor: Colors.black54,
        unselectedLabelColor: Colors.grey,
        onTap: (index) {},
      ),
    );
  }

}

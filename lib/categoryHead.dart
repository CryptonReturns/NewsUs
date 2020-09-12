import 'package:concentric_transition/concentric_transition.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileData{
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  TileData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class Concentric extends StatelessWidget {
  final List<TileData> pages = [
    TileData(
      icon: Icons.format_size,
      title: "News Category 1",
      textColor: Colors.white,
      bgColor: Color(0xFFFDBFDD),
    ),

    TileData(
      icon: Icons.hdr_weak,
      title: "News Category 2",
      bgColor: Color(0xFFFFFFFF),
    ),

    TileData(
      icon: Icons.bubble_chart,
      title: "News Category 3",
      bgColor: Color(0xFF0043D0),
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: ConcentricPageView(
          colors: colors,
          opacityFactor: 1.0,
          scaleFactor: 0.0,
          radius: 500,
          curve: Curves.ease,
          duration: Duration(seconds: 3),
          verticalPosition: 0.7,
          direction: Axis.vertical,

          itemBuilder: (index, value) {
            TileData page = pages[index % pages.length];
            // For example scale or transform some widget by [value] param
            //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
            return Container(
              child: Theme(
                data: ThemeData(
                  textTheme: TextTheme(
                    title: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Helvetica',
                      letterSpacing: 0.0,
                      fontSize: 36,
                    ),
                    subtitle: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: TileCard(page: page),
              ),
            );
          },
        ),
      ),
    );
  }
}



class TileCard extends StatelessWidget {

  final TileData page;

  const TileCard({
    Key key,
    @required this.page,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        children: <Widget>[
          _buildPicture(context),
          SizedBox(height: 80),
          _buildText(context),
        ],
      ),
    );
  }



  Widget _buildText(BuildContext context) {

    return Text(
      page.title,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    );

  }

  Widget _buildPicture(

      BuildContext context, {
        double size = 190,
        double iconSize = 170,
      }) {
    return Container(


      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
        color: page.bgColor
            .withGreen(page.bgColor.green + 20)
            .withRed(page.bgColor.red - 100)
            .withAlpha(90),
      ),
      margin: EdgeInsets.only(
        top: 140,
      ),


      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Positioned.fill(

            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: page.bgColor
                    .withBlue(page.bgColor.blue - 10)
                    .withGreen(220),
              ),
            ),
            right: -5,
            bottom: -5,
          ),

          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: page.bgColor.withGreen(66).withRed(77),
              ),
            ),
          ),
          Icon(
            page.icon,
            size: iconSize,
            color: page.bgColor.withRed(111).withGreen(220),
          ),
        ],
      ),
    );
  }
}
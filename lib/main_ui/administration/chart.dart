import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:charts_common/common.dart' as commonCharts;



class Chart1 extends StatefulWidget {


  _Chart1State createState() => _Chart1State();
}

class _Chart1State extends State<Chart1> {

  List<charts.Series<Pollution, String>> _seriesData;

  _generateData() {
    var data1 = [
      new Pollution('Dec', 3000),
      new Pollution('Jan', 2800),
      new Pollution('Feb', 2700),
      new Pollution('Mar', 1500),
      new Pollution('Apr', 2900),
      new Pollution('May', 700),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,

        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(AppColors.REQUEST_UPPER),
      ),
    );

  }

  @override
  void initState() {
    _seriesData = List<charts.Series<Pollution, String>>();
    _generateData();
    super.initState();
  }

  final spaceBetweenBars = 13.0;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _seriesData,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
      //behaviors: [new charts.SeriesLegend()],
      animationDuration: Duration(seconds: 2),

      defaultRenderer: new charts.BarRendererConfig(

          cornerStrategy: const charts.ConstCornerStrategy(30)),

      domainAxis: new charts.OrdinalAxisSpec(
          scaleSpec: commonCharts.FixedPixelOrdinalScaleSpec(spaceBetweenBars),
          renderSpec: new charts.SmallTickRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),

      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 10, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),



    );
  }


}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.place, this.quantity);

}

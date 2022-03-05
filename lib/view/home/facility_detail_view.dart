import 'package:agriverts/core/constants/app_constants.dart';
import 'package:agriverts/product/widgets/gauge_chart.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class FacilityDetail extends StatelessWidget {
  final String facilityName;
  FacilityDetail({Key? key, required this.facilityName}) : super(key: key);
  late Size screenSize;
  List<double> data = [
    0.0,
    1.0,
    1.5,
    0.0,
    0.0,
    1.0,
    -0.5,
    -1.0,
    -0.5,
    0.0,
    0.0
  ];
  List<double> data2 = [
    1.0,
    1.5,
    1.5,
    0.0,
    0.5,
    0.0,
    -0.5,
    -1.0,
    -0.5,
  ];
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(facilityName),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstant.facilityTitle1,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 200,
                      width: screenSize.width,
                      child: Center(
                        child: PieChart(
                          dataMap: dataMap,
                          chartType: ChartType.ring,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Ortam Koşulları',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildLineChart(title: 'Sıcaklık', prefix: '°C'),
                    buildLineChart(title: 'Nem', prefix: '%'),
                    buildLineChart(title: 'pH'),
                    buildLineChart(title: 'CO2 Miktarı', prefix: 'ppm'),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              width: screenSize.width,
              child: Center(
                child: Container(
                  width: screenSize.width * 0.6,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Canlı Görüntüyü Başlat',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildLineChart({required String title, String prefix = ' '}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Sparkline(
            data: data,
            gridLinelabelPrefix: prefix,
            gridLineLabelPrecision: 3,
            enableGridLines: true,
            useCubicSmoothing: true,
          ),
        ],
      ),
    );
  }
}
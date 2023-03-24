import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarCharts extends StatefulWidget {
  const BarCharts({super.key});

  @override
  State<StatefulWidget> createState() => BarChartsState();
}

class BarChartsState extends State<BarCharts> {
  static const double barWidth = 30;
  static const shadowOpacity = 0.2;
  static const mainItems = <int, List<double>>{
    0: [10],
    1: [-10],
    2: [10],
    3: [10],
    4: [-10],
    5: [10],
    6: [10],
    7: [-10],
    8: [10],
    9: [10],
    10: [-10],
    11: [10],
  };
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Янв';
        break;
      case 1:
        text = 'Фев';
        break;
      case 2:
        text = 'Мар';
        break;
      case 3:
        text = 'Апр';
        break;
      case 4:
        text = 'Май';
        break;
      case 5:
        text = 'Июн';
        break;
      case 6:
        text = 'Июл';
        break;
      case 7:
        text = 'Авг';
        break;
      case 8:
        text = 'Сен';
        break;
      case 9:
        text = 'Окт';
        break;
      case 10:
        text = 'Ноя';
        break;
      case 11:
        text = 'Дек';
        break;

      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  BarChartGroupData generateGroup(
    int x,
    double numberAnalyze,
  ) {
    final isTop = numberAnalyze > 0;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: numberAnalyze,
          width: barWidth,
          color: numberAnalyze > 0 ? Colors.green : Colors.red,
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
        ),
        BarChartRodData(
          toY: -numberAnalyze,
          width: barWidth,
          color: Colors.transparent,
          borderRadius: isTop
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
        ),
      ],
    );
  }

  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isShadowBar(int rodIndex) => rodIndex == 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orient = MediaQuery.of(context).orientation;
    return
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: orient == Orientation.landscape
                      ? size.width
                      : size.width * 1.5,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceEvenly,
                        maxY: 15,
                        minY: -15,
                        groupsSpace: 16,
                        barTouchData: BarTouchData(
                          handleBuiltInTouches: false,
                          touchCallback:
                              (FlTouchEvent event, barTouchResponse) {
                            if (!event.isInterestedForInteractions ||
                                barTouchResponse == null ||
                                barTouchResponse.spot == null) {
                              setState(() {
                                touchedIndex = -1;
                              });
                              return;
                            }
                            final rodIndex =
                                barTouchResponse.spot!.touchedRodDataIndex;
                            if (isShadowBar(rodIndex)) {
                              setState(() {
                                touchedIndex = -1;
                              });
                              return;
                            }
                            setState(() {
                              touchedIndex =
                                  barTouchResponse.spot!.touchedBarGroupIndex;
                            });
                          },
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                              reservedSize: 32,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: bottomTitles,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                              // getTitlesWidget: leftTitles,
                              interval: 5,
                              reservedSize: 42,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                              interval: 5,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          checkToShowHorizontalLine: (value) => value % 5 == 0,
                          getDrawingHorizontalLine: (value) {
                            if (value == 0) {
                              return FlLine(
                                color: Colors.black.withOpacity(0.1),
                                strokeWidth: 3,
                              );
                            }
                            return FlLine(
                              color: Colors.transparent,
                              strokeWidth: 0,
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: mainItems.entries
                            .map(
                              (e) => generateGroup(
                                e.key,
                                e.value[0],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            );
  }
}

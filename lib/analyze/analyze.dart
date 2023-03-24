import 'package:flutter/material.dart';

import 'chart.dart';

class analyzePage extends StatelessWidget {
  const analyzePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Анализ бюджета"), backgroundColor: Colors.green[800],),
      body: Container(
        height: 300,
        child: BarCharts(),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reading Stats')),
      body: FutureBuilder(
        future: Future.wait([
          context.read<BooksProvider>().getRead(),
          context.read<BooksProvider>().getReading(),
          context.read<BooksProvider>().getToRead(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final read = snapshot.data![0].length.toDouble();
          final reading = snapshot.data![1].length.toDouble();
          final toRead = snapshot.data![2].length.toDouble();

          final sections = [
            PieChartSectionData(value: read, color: Colors.green, title: 'Read'),
            PieChartSectionData(value: reading, color: Colors.orange, title: 'Reading'),
            PieChartSectionData(value: toRead, color: Colors.blue, title: 'To Read'),
          ];

          return Center(
            child: SizedBox(
              height: 240,
              child: PieChart(PieChartData(sections: sections, centerSpaceRadius: 32)),
            ),
          );
        },
      ),
    );
  }
}



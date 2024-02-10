import 'package:flutter/material.dart';
import 'package:jpr/services/fetch.dart';

import '../no_data.dart';

class MilkProduction extends StatefulWidget {
  const MilkProduction({Key? key}) : super(key: key);

  @override
  State<MilkProduction> createState() => _MilkProductionState();
}

class _MilkProductionState extends State<MilkProduction> {
  var elements = FetchData.getData(table: "milk", field: 'id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Milk Production"),
      ),
      body: FutureBuilder(
        future: elements,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;

          if(data.isEmpty){
            return const NoData();
          }

          return SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("From")),
                  DataColumn(label: Text("Morning")),
                  DataColumn(label: Text("Evening")),
                  DataColumn(label: Text("Daily")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Created At")),
                ],
                rows: List.generate(
                  data.length,
                  (index) => DataRow(cells: [
                    DataCell(Text("${data[index]['id']!}")),
                    DataCell(Text(data[index]['from'] ?? "None")),
                    DataCell(Text("${data[index]['morning'] ?? "None"} ltrs")),
                    DataCell(Text("${data[index]['evening'] ?? "None"} ltrs")),
                    DataCell(Text(
                        "${(data[index]['morning'] + data[index]['evening']) ?? "None"}")),
                    DataCell(Text(data[index]['date']!)),
                    DataCell(Text(data[index]['created_at']!)),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            elements =
                FetchData.getData(table: "milk", field: 'id');
          });
        },
      ),
    );
  }
}

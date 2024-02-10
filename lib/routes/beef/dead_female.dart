import 'package:flutter/material.dart';
import 'package:jpr/services/fetch.dart';

import '../no_data.dart';

class DeadFemales extends StatefulWidget {
  const DeadFemales({Key? key}) : super(key: key);

  @override
  State<DeadFemales> createState() => _DeadFemalesState();
}

class _DeadFemalesState extends State<DeadFemales> {
  var elements =
      FetchData.getSQLData(table: "female_cows", dead: true, field: 'id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Female Dead Cows"),
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
                  DataColumn(label: Text("Date of Death")),
                  DataColumn(label: Text("Created At")),
                ],
                rows: List.generate(
                  data.length,
                  (index) => DataRow(cells: [
                    DataCell(Text("${data[index]['id']!}")),
                    DataCell(Text(data[index]['DoD'] ?? "None")),
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
            elements = FetchData.getSQLData(
                table: "female_cows", dead: true, field: 'id');
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jpr/services/fetch.dart';

import '../no_data.dart';

class SoldMale extends StatefulWidget {
  const SoldMale({Key? key}) : super(key: key);

  @override
  State<SoldMale> createState() => _SoldMaleState();
}

class _SoldMaleState extends State<SoldMale> {
  var elements =
      FetchData.getSQLData(table: "male_cows", sold: true, field: 'id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Male Sold Cows"),
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
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Date of Sale")),
                  DataColumn(label: Text("Created At")),
                ],
                rows: List.generate(
                  data.length,
                  (index) => DataRow(cells: [
                    DataCell(Text("${data[index]['id']!}")),
                    DataCell(Text("${data[index]['price']}" ?? "None")),
                    DataCell(Text(data[index]['DoS'] ?? "None")),
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
                table: "male_cows", sold: true, field: 'id');
          });
        },
      ),
    );
  }
}

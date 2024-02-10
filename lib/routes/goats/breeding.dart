import 'package:flutter/material.dart';
import 'package:jpr/services/fetch.dart';

import '../no_data.dart';

class Breeding extends StatefulWidget {
  const Breeding({Key? key}) : super(key: key);

  @override
  State<Breeding> createState() => _BreedingState();
}

class _BreedingState extends State<Breeding> {
  var elements =
      FetchData.getData(table: "mating_goats", field: 'id');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breeding"),
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
                  DataColumn(label: Text("Male")),
                  DataColumn(label: Text("Female")),
                  DataColumn(label: Text("Created At")),
                ],
                rows: List.generate(
                  data.length,
                  (index) => DataRow(cells: [
                    DataCell(Text("${data[index]['id']!}")),
                    DataCell(Text(data[index]['male'] ?? "None")),
                    DataCell(Text(data[index]['female'] ?? "None")),
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
            elements = FetchData.getData(
                table: "mating_goats", field: 'id');
          });
        },
      ),
    );
  }
}

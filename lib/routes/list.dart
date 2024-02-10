// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:jpr/routes/individual.dart';
import 'package:jpr/routes/no_data.dart';
import 'package:jpr/services/fetch.dart';


class FList extends StatefulWidget {
  String table;
  String id;
  String field;
  FList(this.table, this.id, this.field, {Key? key}) : super(key: key);

  @override
  State<FList> createState() => _FListState(table, id, field);
}

class _FListState extends State<FList> {
  String table;
  String id;
  String field;

  _FListState(this.table, this.id, this.field);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(table.split("_").join(" ").toUpperCase()),
      ),
      body: FutureBuilder(
        future: FetchData.getWhere(table: table, id: id, field: field),
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
                  DataColumn(label: Text("Father")),
                  DataColumn(label: Text("Mother")),
                  DataColumn(label: Text("Date of Birth")),
                  DataColumn(label: Text("Category")),
                  DataColumn(label: Text("Created At")),
                ],
                rows: List.generate(
                  data.length,
                      (index) => DataRow(
                      onLongPress: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SingleAnimal(id: data[index]["id"], table: table,);
                        }));
                      },
                      cells: [
                        DataCell(Text(data[index]['id']!)),
                        DataCell(Text(data[index]['father'] ?? "None")),
                        DataCell(Text(data[index]['mother'] ?? "None")),
                        DataCell(Text(data[index]['DoB'] ?? "None")),
                        DataCell(Text(data[index]['category']!)),
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
            // elements = FetchData.getData(
            //     table: table, order: true, field: 'id');
          });
        },
      ),
    );
  }
}

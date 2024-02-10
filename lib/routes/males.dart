// ignore_for_file: must_be_immutable, no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/query.dart';
import 'package:jpr/services/fetch.dart';

import 'add_animal.dart';
import 'individual.dart';
import 'no_data.dart';

class Males extends StatefulWidget {
  String table = "";
  var query;
  Males(this.table, this.query, {Key? key}) : super(key: key);

  @override
  State<Males> createState() => _MalesState(table, query);
}

class _MalesState extends State<Males> {
  String table = "";
  var query;
  var elements = FetchData.getSQLData(table: "none", field: 'id');

  _MalesState(this.table, this.query) {
    elements = query.runtimeType != bool
        ? query
        : FetchData.getSQLData(table: table, field: 'id');
  }

  String selected = "id";
  int total = 0;
  List<String> keys = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(table.split("_").join(" ").toUpperCase()),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          height: size.height * 0.5,
                          width: size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.9,
                                    child: TextFormField(
                                      onFieldSubmitted: (text) {
                                        text = text.capitalizeFirst!;
                                        Get.back();
                                        Get.to(
                                          () => Males(
                                            table,
                                            FetchData.getWhere(
                                                table: table,
                                                field: selected,
                                                id: text),
                                          ),
                                        );
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Search",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DropdownMenu(
                                initialSelection: selected,
                                onSelected: (text) {
                                  selected = text!;
                                },
                                dropdownMenuEntries: List.generate(
                                  keys.length,
                                  (index) => DropdownMenuEntry(
                                    value: keys[index],
                                    label: keys[index],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                },
                icon: const Icon(Icons.filter_alt))
          ]),
      body: FutureBuilder(
        future: elements,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.data!;

          if (data.isEmpty) {
            return const NoData();
          }

          total = data.length;

          keys = data[0].keys.toList();

          return SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Total: ",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$total",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  DataTable(
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
                              return SingleAnimal(
                                id: data[index]["id"],
                                table: table,
                              );
                            }));
                          },
                          cells: [
                            DataCell(GestureDetector(
                              onTap: () {
                                Get.to(() => SingleAnimal(
                                  id: data[index]["id"],
                                  table: table,
                                ));
                              },
                              child: Text("${data[index]['id']!}"),
                            )),
                            DataCell(Text(data[index]['father'] ?? "None")),
                            DataCell(Text(data[index]['mother'] ?? "None")),
                            DataCell(Text(data[index]['DoB'] ?? "None")),
                            DataCell(Text(data[index]['category']!)),
                            DataCell(Text(data[index]['created_at']!)),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(() => AddAnimal(table));
        },
      ),
    );
  }
}

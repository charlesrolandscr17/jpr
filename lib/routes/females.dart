// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/add_animal.dart';
import 'package:jpr/routes/individual.dart';
import 'package:jpr/services/fetch.dart';

import '../controllers/selected.dart';
import 'males.dart';
import 'no_data.dart';

class Females extends StatefulWidget {
  String table;
  var query;
  Females(this.table, this.query, {Key? key}) : super(key: key);

  @override
  State<Females> createState() => _FemalesState(table, query);
}

class _FemalesState extends State<Females> {
  var elements = FetchData.getSQLData(table: "table", field: 'id');
  String table;
  var query;

  _FemalesState(this.table, this.query) {
    elements = query.runtimeType != bool
        ? query
        : FetchData.getSQLData(table: table, field: 'id');
  }

  String selected = "id";
  bool? isPregnant = false;
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
                                        // Get.back();
                                        if (selected == "is_pregnant") {
                                          bool val = true;
                                          if (text == "False") {
                                            val = false;
                                          }
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Females(
                                              table,
                                              FetchData.getWhere(
                                                  table: table,
                                                  field: selected,
                                                  id: val),
                                            );
                                          }));
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Females(
                                              table,
                                              FetchData.getWhere(
                                                  table: table,
                                                  field: selected,
                                                  id: text),
                                            );
                                          }));
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: "Search ID",
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
          total = data.length;
          if (data.isEmpty) {
            return const NoData();
          }
          keys = data[0].keys.toList();
          return SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
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
                  ),
                  DataTable(
                    sortColumnIndex: 0,
                    sortAscending: true,
                    columns: const [
                      DataColumn(label: Text("ID")),
                      DataColumn(label: Text("Father")),
                      DataColumn(label: Text("Mother")),
                      DataColumn(label: Text("Is Pregnant")),
                      DataColumn(label: Text("Date of Birth")),
                      DataColumn(label: Text("Category")),
                      DataColumn(label: Text("Created At")),
                    ],
                    rows: List.generate(data.length, (index) {
                      return DataRow(
                        onLongPress: (){
                          Get.to(() => SingleAnimal(
                            id: data[index]["id"],
                            table: table,
                          ));
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
                        DataCell(Checkbox(
                            value: data[index]['is_pregnant']!,
                            onChanged: (changed) async {
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return SimpleDialog(
                                      title: const Text("Are You Sure?"),
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                data[index]['is_pregnant'] =
                                                    changed;
                                              });
                                              Navigator.of(context).pop();
                                              await FetchData.supabase
                                                  .from(table)
                                                  .update({
                                                'is_pregnant': changed!
                                              }).match({
                                                'id': data[index]['id']
                                              });
                                            },
                                            child: const Text("Yes")),
                                        TextButton(
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("No")),
                                      ],
                                    );
                                  });
                            })),
                        DataCell(Text(data[index]['DoB'] ?? "None")),
                        DataCell(Text(data[index]['category']!)),
                        DataCell(Text(data[index]['created_at'] ?? "None")),
                      ]);
                    }),
                  )
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

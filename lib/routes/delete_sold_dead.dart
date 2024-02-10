import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/home.dart';
import 'package:jpr/services/fetch.dart';
import 'dart:developer' as developer;
import '../controllers/selected.dart';

// ignore: must_be_immutable
class DSD extends StatefulWidget {
  String table = "";
  DSD({required this.table, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<DSD> createState() => _DSDState(table);
}

String value = "None";

SelectedController isSelected = Get.put(SelectedController());

class _DSDState extends State<DSD> {
  String table = "";
  // ignore: prefer_typing_uninitialized_variables
  var query;
  _DSDState(this.table) {
    query = FetchData.getSQLData(table: table, field: 'id');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Actions:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
              value: value,
              items: const [
                DropdownMenuItem(
                  value: "Delete",
                  child: Text("Delete"),
                ),
                DropdownMenuItem(
                  value: "None",
                  child: Text("None"),
                ),
                DropdownMenuItem(
                  value: "Dead",
                  child: Text("Dead"),
                ),
                DropdownMenuItem(
                  value: "Sold",
                  child: Text("Sold"),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  value = newValue!;
                });
              }),
          ElevatedButton(
            onPressed: () {
              if (value == "Delete") {
                isSelected.deleteSelected(table);
              } else if (value == "Dead") {
                isSelected.soldSelected();
                developer.log("Dead");
              } else if (value == "Sold") {
                isSelected.soldSelected();
                developer.log("Sold");
              } else {}
              isSelected.setIsSelected(table);
              Get.back();
              Get.offAll(() => const Home());
            },
            child: const Text(
              "Accept",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/list.dart';

class AnimalList extends StatelessWidget {
   String table;
   String id = "";
   String field;
  AnimalList({required this.table, required this.id, required this.field, Key? key}) : super(key: key){
    table = table.split("_").getRange(1, table.split("_").length).join("_");
    if(field == "female"){
      field = "mother";
    }else{
      field = "father";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(table.split("_").join(" ").toUpperCase()),
      ),
      body: Column(
        children: [
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.green, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Male",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading:
                  const Icon(Icons.male, color: Colors.greenAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return FList("male_$table", id, field);
                }));
              },
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.pink, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Female",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.female,
                  color: Colors.pinkAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Get.to(() => FList("female_$table", id, field));
              },
            ),
          ),
        ],
      ),
    );
  }
}

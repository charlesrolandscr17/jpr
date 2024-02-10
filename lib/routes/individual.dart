// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/animal_list.dart';
import 'package:jpr/routes/edit_animal.dart';
import 'package:jpr/routes/home.dart';

import '../services/fetch.dart';

class SingleAnimal extends StatelessWidget {
  var data;
  String id = "";
  String table = "";

  SingleAnimal({required this.id, required this.table, super.key}) {
    data = FetchData.get(table: table, id: id);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
      body: FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var data = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: ResizeImage(
                                NetworkImage(
                                  FetchData.supabase.storage
                                      .from('diary_cows')
                                      .getPublicUrl('${data["id"]}.jpg'),
                                ),
                                width: width.toInt(),
                                height: (height.toInt() * 0.5).toInt(),
                                allowUpscaling: true))),
                  ),
                ),
                Divider(
                  height: height * 0.005,
                  thickness: 5,
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Name:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["name"] ?? "none",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "ID:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["id"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Mother:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (data["mother"] != null) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              table = table.split("_").length > 2
                                  ? table.split("_").getRange(1, 3).join("_")
                                  : table.split("_")[1];
                              return SingleAnimal(
                                  id: data["mother"], table: "female_$table");
                            }));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            data["mother"] ?? "No Mother",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Father:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["father"] ?? "No Father",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Date of Birth:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["DoB"] ?? "None",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Category:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["category"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Breed:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          data["breed"] ?? "None",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Pregnancy:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${data["is_pregnant"]}'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Expected Milk:",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${data["expected_milk"]}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.009,
                ),
                Card(
                  margin: const EdgeInsets.only(left: 8.0),
                  elevation: 2,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Children: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return AnimalList(
                                table: table,
                                id: data["id"],
                                field: table.split("_")[0],
                              );
                            }));
                          },
                          child: const Text(
                            "Go To",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.blue,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        FetchData.delete(table, id);
                        Get.offAll(const Home());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red),
                      ),
                      child: const Text("Delete"),
                    ),ElevatedButton(
                      onPressed: () {
                        Get.to(() => EditAnimal(table, id));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                      ),
                      child: const Text("Edit"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

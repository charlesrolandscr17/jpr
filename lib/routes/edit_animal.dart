// ignore_for_file: body_might_complete_normally_catch_error, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jpr/controllers/getData.dart';
import 'package:jpr/routes/home.dart';
import 'package:jpr/services/fetch.dart';

import 'no_data.dart';

class EditAnimal extends StatefulWidget {
  EditAnimal(this.table, this.id, {super.key});

  String table;
  String id;

  @override
  State<EditAnimal> createState() => _EditAnimalState(table, id);
}

class _EditAnimalState extends State<EditAnimal> {
  _EditAnimalState(this.table, this.id);

  String table;
  String id;
  final _formKey = GlobalKey<FormBuilderState>();

  GetDataController controller = Get.find();

  TextEditingController controller_id = TextEditingController();

  TextEditingController name = TextEditingController();

  bool? isPregnant;

  // DateTime? dob = DateTime.now();
  String dob = "Pick Date";

  TextEditingController father = TextEditingController();

  TextEditingController mother = TextEditingController();

  TextEditingController category = TextEditingController();

  TextEditingController milk = TextEditingController();

  TextEditingController breed = TextEditingController();

  bool? dead;

  XFile? image;

  bool? sold;
  bool changed = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: FetchData.get(table: table, id: id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return const NoData();
            }
            controller_id.text = data["id"];

            name.text = data["name"];

            if (!changed) {
              isPregnant = data["is_pregnant"];
              sold = data["sold"];
              dead = data["dead"];
              changed = true;
              dob = data["DoB"];

              category.text = data["category"];

              milk.text = data["expected_milk"].toString() ?? "";

              breed.text = data["breed"];
              mother.text = data["mother"] ?? "";
              father.text = data["father"] ?? "";
            }

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: FormBuilder(
                  key: _formKey,
                  child: ListView(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image.
                          image = await picker.pickImage(
                              source: ImageSource.gallery);
                        },
                        child: const Text(
                          "Select Image",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      FormBuilderTextField(
                        controller: controller_id,
                        name: 'id',
                        decoration: const InputDecoration(labelText: 'ID'),
                      ),
                      FormBuilderTextField(
                        controller: name,
                        name: 'name',
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 1825)),
                            lastDate: DateTime.now(),
                          );
                          setState(() {
                            dob = DateFormat.yMMMd()
                                .format(date ?? DateTime.now());
                          });
                        },
                        child: Text(
                          dob,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      FormBuilderTextField(
                        controller: category,
                        name: 'category',
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                      ),
                      FormBuilderTextField(
                        controller: breed,
                        name: 'breed',
                        decoration: const InputDecoration(labelText: 'Breed'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DropdownMenu(
                            hintText: "Select Father",
                            menuHeight: size.height * 0.5,
                            width: size.width * 0.9,
                            controller: father,
                            dropdownMenuEntries: controller.males.isNotEmpty
                                ? List.generate(
                                    controller.males.length,
                                    (index) => DropdownMenuEntry(
                                        value: controller.males[index]["id"],
                                        label: controller.males[index]["id"]))
                                : [
                                    const DropdownMenuEntry(
                                        value: null, label: 'None')
                                  ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: DropdownMenu(
                            hintText: "Select Mother",
                            menuHeight: size.height * 0.5,
                            width: size.width * 0.9,
                            controller: mother,
                            dropdownMenuEntries: controller.females.isNotEmpty
                                ? List.generate(
                                    controller.females.length,
                                    (index) => DropdownMenuEntry(
                                        value: controller.females[index]["id"],
                                        label: controller.females[index]["id"]))
                                : [
                                    const DropdownMenuEntry(
                                        value: null, label: 'None')
                                  ]),
                      ),
                      Visibility(
                        visible:
                            table.split("_")[table.split("_").length - 1] ==
                                    "diary" &&
                                table.split("_")[0] == "female",
                        child: FormBuilderTextField(
                          controller: milk,
                          name: 'milk',
                          decoration: const InputDecoration(labelText: 'Milk'),
                        ),
                      ),
                      Visibility(
                        visible: table.split("_")[0] == "female",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Is Pregnant: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            DropdownButton(
                                value: isPregnant,
                                items: const [
                                  DropdownMenuItem(
                                    value: true,
                                    child: Text("True"),
                                  ),
                                  DropdownMenuItem(
                                    value: false,
                                    child: Text("False"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    isPregnant = value!;
                                  });
                                })
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sold: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                              value: sold,
                              items: const [
                                DropdownMenuItem(
                                  value: true,
                                  child: Text("True"),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text("False"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  sold = value!;
                                });
                              })
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dead",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                              value: dead,
                              items: const [
                                DropdownMenuItem(
                                  value: true,
                                  child: Text("True"),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Text("False"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dead = value!;
                                });
                              })
                        ],
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.blue),
                          ),
                          onPressed: () {
                            Map new_items;

                            print(mother.text);
                            print(father.text);
                            print(father.text.runtimeType);
                            if (milk.text.isEmpty) {
                              milk.text = "0";
                            }
                            if (table.split("_")[0] == "female") {
                              if (table.split(
                                      "_")[table.split("_").length - 1] ==
                                  "diary") {
                                if (mother.text.isEmpty &&
                                    father.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "category": category.text,
                                    "breed": breed.text,
                                    "expected_milk": milk.text,
                                  };
                                } else if (mother.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "father": father.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                    "expected_milk": milk.text,
                                  };
                                } else if (father.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "mother": mother.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                    "expected_milk": milk.text,
                                  };
                                } else {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "mother": mother.text,
                                    "father": father.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                    "expected_milk": milk.text,
                                  };
                                }
                              } else {
                                if (mother.text.isEmpty &&
                                    father.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "category": category.text,
                                    "breed": breed.text,
                                  };
                                } else if (mother.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "father": father.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                  };
                                } else if (father.text.isEmpty) {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "mother": mother.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                  };
                                } else {
                                  new_items = {
                                    "name": name.text,
                                    "id": controller_id.text,
                                    "sold": sold,
                                    "dead": dead,
                                    "is_pregnant": isPregnant,
                                    "DoB": dob,
                                    "mother": mother.text,
                                    "father": father.text,
                                    "category": category.text,
                                    "breed": breed.text,
                                  };
                                }
                              }
                            } else {
                              if (mother.text.isEmpty && father.text.isEmpty) {
                                new_items = {
                                  "name": name.text,
                                  "id": controller_id.text,
                                  "sold": sold,
                                  "dead": dead,
                                  "DoB": dob,
                                  "category": category.text,
                                  "breed": breed.text,
                                };
                              } else if (mother.text.isEmpty) {
                                new_items = {
                                  "name": name.text,
                                  "id": controller_id.text,
                                  "sold": sold,
                                  "dead": dead,
                                  "DoB": dob,
                                  "father": father.text,
                                  "category": category.text,
                                  "breed": breed.text,
                                };
                              } else if (father.text.isEmpty) {
                                new_items = {
                                  "name": name.text,
                                  "id": controller_id.text,
                                  "sold": sold,
                                  "dead": dead,
                                  "DoB": dob,
                                  "mother": mother.text,
                                  "category": category.text,
                                  "breed": breed.text,
                                };
                              } else {
                                new_items = {
                                  "name": name.text,
                                  "id": controller_id.text,
                                  "sold": sold,
                                  "dead": dead,
                                  "DoB": dob,
                                  "mother": mother.text,
                                  "father": father.text,
                                  "category": category.text,
                                  "breed": breed.text,
                                };
                              }
                            }

                            if (image != null) {
                              FetchData.upload(image!.path, controller_id.text);
                            }

                            FetchData.update(table, new_items, id)
                                .then(
                                    (value) => {Get.offAll(() => const Home())})
                                .catchError((error) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: AlertDialog(
                                        title: const Text("Error"),
                                        content: Column(children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Message",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${error.message}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Hint",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${error.hint}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Details",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${error.details}",
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "code",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  "${error.code}",
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: const TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    );
                                  });
                            });
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )),
            );
          }),
    );
  }
}

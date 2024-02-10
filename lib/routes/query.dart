// // ignore_for_file: must_be_immutable, no_logic_in_create_state, prefer_typing_uninitialized_variables
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:jpr/routes/females.dart';
// import 'package:multi_select_flutter/multi_select_flutter.dart';
//
// import '../services/fetch.dart';
// import 'males.dart';
//
// class Query extends StatefulWidget {
//   String table = "";
//   String txt1 = "";
//   bool? isPregnant = false;
//   List<String> keys;
//   Query(
//       {required this.table,
//       required this.txt1,
//       required this.isPregnant,
//       required this.keys,
//       super.key});
//
//   @override
//   State<Query> createState() => _QueryState(table, txt1, isPregnant, keys);
// }
//
// class _QueryState extends State<Query> {
//   String table = "";
//   String txt1 = "";
//   bool? isPregnant = false;
//   var field = "None";
//
//   List<String> _selectedColumns = [];
//   List<String> _values = [];
//   List<String> keys = [];
//   _QueryState(this.table, this.txt1, this.isPregnant, this.keys);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Column(
//       // title: const Text("Enter Your Query or Queries"),
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(right: 18.0),
//                     child: Text(
//                       "Field:",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.15,
//                     width: size.width * 0.7,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         MultiSelectDialogField(
//                           items: keys.map((e) => MultiSelectItem(e, e)).toList(),
//                           listType: MultiSelectListType.CHIP,
//                           onConfirm: (values) {
//                             _selectedColumns = values;
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.only(right: 18.0),
//                     child: Text(
//                       "Input:",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onChanged: (txt) {
//                         txt1 = txt.toUpperCase();
//                       },
//                       decoration:
//                           const InputDecoration(label: Text("Category")),
//                     ),
//                   ),
//                 ],
//               ),
//               Visibility(
//                 visible: table.split("_")[0] == "female",
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Is Pregnant: ",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     DropdownButton(
//                         value: isPregnant,
//                         items: const [
//                           DropdownMenuItem(
//                             value: true,
//                             child: Text("True"),
//                           ),
//                           DropdownMenuItem(
//                             value: false,
//                             child: Text("False"),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             isPregnant = value;
//                           });
//                         })
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: ElevatedButton(
//                     style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.all(Colors.blue)),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       if (table.split("_")[0] == "female") {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return Females(
//                               table,
//                               FetchData.getWhereMulCol(
//                                   table, _selectedColumns, _values));
//                         }));
//                       } else {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return Males(
//                               table,
//                               FetchData.getWhereMulCol(
//                                   table, _selectedColumns, _values));
//                         }));
//                       }
//                     },
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(color: Colors.black),
//                     )),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

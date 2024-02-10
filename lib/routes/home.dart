import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/payroll.dart';
import 'package:jpr/routes/todos.dart';
import 'package:jpr/routes/goats.dart';
import 'package:jpr/routes/diary.dart';
import 'package:jpr/routes/beef.dart';
import 'package:jpr/services/fetch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/getData.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  int i = 0;
  int goats = 0;
  int cows = 0;
  int diary = 0;

  // Color color =  CustomColors.primary;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GetDataController());
    Timer(const Duration(milliseconds: 0), () async {
      var data1 = await FetchData.supabase
          .from("male_goats")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);
      var data2 = await FetchData.supabase
          .from("female_goats")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);;
      var data3 = await FetchData.supabase
          .from("male_cows")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);;
      var data4 = await FetchData.supabase
          .from("female_cows")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);;
      var data5 = await FetchData.supabase
          .from("male_cows_diary")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);;
      var data6 = await FetchData.supabase
          .from("female_cows_diary")
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq("dead", false)
          .eq("sold", false);;
      setState(() {
        goats = data1.count + data2.count;
        cows = data3.count + data4.count;
        diary = data6.count + data5.count;
      });
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("JPR Management"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(30))),
              child: Column(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC7nwpV3M_hi-AGM6u7RJZrChPwbTzUTz7OA&usqp=CAU"),
                  radius: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "JPR Farm",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$cows',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const Text(
                        'Cows',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$goats',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const Text(
                        'Goats',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '$diary',
                        style: const TextStyle(fontSize: 22),
                      ),
                      const Text(
                        'Diary Cows',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Card(
                    color: Colors.white,
                    shape: const BorderDirectional(
                        start: BorderSide(color: Colors.redAccent, width: 5)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const GoatPage());
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.red,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Goats",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Card(
                    color: Colors.white,
                    shape: const BorderDirectional(
                        start: BorderSide(color: Colors.amberAccent, width: 5)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const BeefCowsPage());
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Beef",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Card(
                    color: Colors.white,
                    shape: const BorderDirectional(
                        start:
                            BorderSide(color: Colors.purpleAccent, width: 5)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const DiaryCowsPage());
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.purple,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Diary",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Card(
                    color: Colors.white,
                    shape: const BorderDirectional(
                        start: BorderSide(color: Colors.greenAccent, width: 5)),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.account_box,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "MM",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.blueAccent, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Todos",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.calendar_today,
                  color: Colors.blue, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Get.to(() => const TodoPage());
              },
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.pinkAccent, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "General Expenses",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading:
                  const Icon(Icons.money, color: Colors.pinkAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {},
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.brown, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Payroll Management",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading:
                  const Icon(Icons.payments, color: Colors.brown, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Get.to(() => const PayrollPage());
              },
            ),
          ),
        ],
      ),
    );
  }
}

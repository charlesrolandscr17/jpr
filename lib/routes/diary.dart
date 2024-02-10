import 'package:flutter/material.dart';
import 'package:jpr/routes/Diary/breeding.dart';
import 'package:jpr/routes/Diary/cow_list.dart';
import 'package:jpr/routes/Diary/dead.dart';
import 'package:jpr/routes/Diary/milk_production.dart';
import 'package:jpr/routes/Diary/sold.dart';

class DiaryCowsPage extends StatefulWidget {
  const DiaryCowsPage({Key? key}) : super(key: key);

  @override
  State<DiaryCowsPage> createState() => _DiaryCowsPageState();
}

class _DiaryCowsPageState extends State<DiaryCowsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diary Cows"),
      ),
      body: ListView(
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
                "Cows List",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.list_alt,
                  color: Colors.greenAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CowsList();
                }));
              },
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.orange, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Breeding",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.child_friendly_rounded,
                  color: Colors.orangeAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Breeding();
                }));
              },
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.red, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Dead",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.disabled_by_default,
                  color: Colors.redAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Dead();
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
                "Sold",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading:
                  const Icon(Icons.sell, color: Colors.pinkAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Sold();
                }));
              },
            ),
          ),
          Card(
            elevation: 2,
            margin: const EdgeInsets.all(10),
            shape: const BorderDirectional(
              start: BorderSide(color: Colors.indigo, width: 5),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: const Text(
                "Milk Produced",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.water_drop,
                  color: Colors.indigoAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const MilkProduction();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jpr/routes/goats/dead_female.dart';
import 'package:jpr/routes/goats/dead_male.dart';
import 'package:jpr/services/fetch.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dead extends StatelessWidget {
  Dead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dead Goats"),
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
                  return const DeadMales();
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
                "Females",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              iconColor: Colors.black,
              textColor: Colors.black,
              leading: const Icon(Icons.female,
                  color: Colors.pinkAccent, weight: 10),
              trailing: const Icon(Icons.arrow_forward_ios_sharp),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const DeadFemales();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

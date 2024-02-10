import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getData.dart';
import '../females.dart';
import '../males.dart';

class CowsList extends StatelessWidget {
  CowsList({Key? key}) : super(key: key){
      controller.getMales("male_cows_diary");
      controller.getFemales("female_cows_diary");
  }
  GetDataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Diary Cows"),
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
                  return Males("male_cows_diary", false);
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
                Get.to(() => Females("female_cows_diary", false));
              },
            ),
          ),
        ],
      ),
    );
  }
}

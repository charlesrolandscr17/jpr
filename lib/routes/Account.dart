import 'package:flutter/material.dart';
import 'package:jpr/routes/home.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JPR Management"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.black,
        onTap: (i) {
          setState(() {
            index = i;
            if (index == 0) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const Home();
              }));
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "account"),
        ],
      ),
    );
  }
}

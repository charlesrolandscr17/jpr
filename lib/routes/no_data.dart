import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.not_interested_outlined, size: 70,),
            Text("No Data", style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}

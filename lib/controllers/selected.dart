import 'package:get/get.dart';

import '../services/fetch.dart';

class SelectedController extends GetxController {
  List<bool> isSelected = [];
  List selected = [];
  bool updated = false;

  setIsSelected(table) async {
    updated = false;
    var num =
        await FetchData.getSQLData(table: table, field: 'id');
    isSelected = List.generate(num.length, (index) => false);
    update();
  }

  deleteSelected(table) {
    for (var id in selected) {
      FetchData.delete(table, id);
    }
    selected = [];
    updated = true;
    update();
  }

  soldSelected() {
    selected = [];
    updated = true;
    update();
  }

  deadSelected() {
    selected = [];
    updated = true;
    update();
  }
}

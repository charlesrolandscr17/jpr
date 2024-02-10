import 'package:get/get.dart';

import '../services/fetch.dart';

class GetDataController extends GetxController{
   var males = [];
   var females = [];
  getData(table) async {
    await FetchData.getSQLData(table: table, field: 'id');
  }

  void getFemales(table) async {
      females = await FetchData.getFieldData(table: table, field: 'id');
   }
   void getMales(table) async {
      males = await FetchData.getFieldData(table: table, field: 'id');
   }
}
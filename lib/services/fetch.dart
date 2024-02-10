import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class FetchData {
  static final supabase = Supabase.instance.client;

  // static void query({table}){
  //   supabase
  // }

  static PostgrestTransformBuilder<List<Map<String, dynamic>>> getData(
      {table, field}) {
      return supabase
          .from(table)
          .select<List<Map<String, dynamic>>>()
          .order(field, ascending: true);
  }

  static PostgrestTransformBuilder<List<Map<String, dynamic>>> getFieldData(
      {table, field}) {
      return supabase
          .from(table)
          .select<List<Map<String, dynamic>>>(field)
          .order(field, ascending: true);
  }

  static PostgrestTransformBuilder<List<Map<String, dynamic>>> getSQLData(
      {table, sold = false, dead = false, field}) {
      return supabase
          .from(table)
          .select<List<Map<String, dynamic>>>()
          .eq("dead", dead)
          .eq("sold", sold)
          .order(field, ascending: true);

  }

  static PostgrestTransformBuilder get({table, id}) {
    return supabase.from(table).select().match({"id": id}).single();
  }

  static PostgrestFilterBuilder<List<Map<String, dynamic>>> getWhere(
      {table, field, id}) {
    if (id == "") {
      return supabase
          .from(table)
          .select<List<Map<String, dynamic>>>()
          .eq(field, id);
    }
    return supabase
        .from(table)
        .select<List<Map<String, dynamic>>>()
        .eq(field, id);
  }

  static PostgrestFilterBuilder<List<Map<String, dynamic>>> getMulWhere(
      {table, column1, value1, column2, value2}) {
    if (column1 == "None") {
      return supabase
          .from(table)
          .select<List<Map<String, dynamic>>>()
          .eq(column2, value2);
    }
    return supabase
        .from(table)
        .select<List<Map<String, dynamic>>>()
        .eq(column1, value1)
        .eq(column2, value2);
  }

  static Future<void> insertData({table, required Map items}) async {
    if (items["mother"] == "") {
      items["mother"] = null;
    }
    if (items["father"] == "") {
      items["father"] = null;
    }
    await supabase.from(table).insert(items);
  }

  static Future<int> getTotal(table) async {
    final data = await supabase
        .from(table)
        .select('*', const FetchOptions(count: CountOption.exact));

    return data.count;
  }

  static update(table, newValues, id) async {
    await
    await supabase
        .from(table)
        .update(newValues)
        .eq('id', id);
  }

  static delete(table, id) async {
    await supabase.from(table).delete().eq('id', id);
  }

  static upload(path, id) async {
    final file = File(path);
    await supabase.storage.from('diary_cows').upload(
          '$id.jpg',
          file,
        );
  }
}

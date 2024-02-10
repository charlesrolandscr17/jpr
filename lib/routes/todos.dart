import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jpr/routes/home.dart';
import 'package:jpr/services/fetch.dart';

import 'no_data.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  var elements = FetchData.getData(table: 'ToDo', field: 'created_at');
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: elements,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final todos = snapshot.data!;
          if(todos.isEmpty){
            return const NoData();
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: ((context, index) {
              final todo = todos[index];
              return Dismissible(
                key: Key(todos[index]["name"]),
                background: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red
                  ),
                    child: const Icon(Icons.delete_forever, color: Colors.white,),),
                onDismissed: (dir) async {
                  await FetchData.supabase.from("ToDo").delete().match({"name": todos[index]["name"]});
                },
                child: Card(
                  elevation: 3,
                  child: CheckboxListTile(
                    title: Text(
                      todo['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    value: todo['is_complete'],
                    onChanged: (bool? value) async {
                      setState(() {
                        todo['is_complete'] = value;
                      });
                      await FetchData.supabase
                          .from('ToDo')
                          .update({'is_complete': value!}).match(
                              {'name': todo['name']});
                    },
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (buildContext) {
                return SimpleDialog(
                  contentPadding: const EdgeInsets.all(20),
                  title: const Text("Add Todo"),
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _controller,
                      onSubmitted: (text) async {
                        Navigator.of(context).pop();
                        Get.to(()=>Home());
                        await FetchData.insertData(
                            items: {"name": text}, table: "ToDo");
                        setState(() {
                          elements = FetchData.getData(table: 'ToDo');
                        });
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

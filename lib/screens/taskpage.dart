import 'package:flutter/material.dart';
import 'package:notes_app/screens/homescreen.dart';
import 'package:notes_app/services/dbFunction.dart';

class TaskPage extends StatefulWidget {

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final todo = TextEditingController();
  final desc = TextEditingController();
  var tasks = [];

  @override
  void initState() {
    loadTask();
    super.initState();
  }

  Future<void> loadTask() async{
    final tsk = await SQHelper.readTask();
    setState(() {
      tasks = tsk;
      tasks.isNotEmpty;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text("Tasks"),
        actions: [
          Icon(Icons.share),
          SizedBox(width: 30),
          // Icon(Icons.delete),
          // SizedBox(width: 20),
          // IconButton(onPressed: (){
          //   //createTask();
          // }, icon: Icon(Icons.add)),
          // SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: todo,
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller: desc,
              decoration: InputDecoration(
                hintText: "Content",
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                onPressed: (){
                  // if(id == null){
                    createTask();
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[200],
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("CREATE", style: TextStyle(color: Colors.white),)
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createTask() async{
    var id = await SQHelper.create(todo.text, desc.text);
    print(id);
    loadTask();
  }
}

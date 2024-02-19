import 'package:flutter/material.dart';
import 'package:notes_app/screens/notepage.dart';
import 'package:notes_app/screens/taskpage.dart';
import 'package:notes_app/services/dbFunction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var tasks = [];
  bool isFabOpen = false;

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
        title: Text("Note"),
      ),
      body: tasks.isEmpty 
          ? Center(
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Tap to add new note"),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => NotePage())
                                );
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit_note),
                                    Text("Note"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => TaskPage())
                                );
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.checklist),
                                    Text("Checklist"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
          )
          : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ), 
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text(tasks[index]['title']),
                    Text(tasks[index]['content'])
                  ],
                ),
              );
            }, 
          ),
          floatingActionButton: tasks.isNotEmpty
          ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
              onPressed: (){
                setState(() {
                  isFabOpen = !isFabOpen;
                });
                if(isFabOpen){}
              },
              shape: CircleBorder(),
              backgroundColor: Colors.purple[200],
              child: isFabOpen ? Icon(Icons.close) : Icon(Icons.add),
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: isFabOpen,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TaskPage())
                    );
                  },
                  child: Icon(Icons.checklist),
                )
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: isFabOpen,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NotePage())
                    );
                  },
                  child: Icon(Icons.edit_note),
                )
              )
            ],
          )
          : Container()
    );
  }
}

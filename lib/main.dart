import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checklist App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'TO DO LIST',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 110, 173),
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 86, 185, 224),
        ),
        body: ChecklistPage(),
      ),
    );
  }
}


class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}


class _ChecklistPageState extends State<ChecklistPage> {
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> archivedTasks = [];
  final _taskController = TextEditingController();


  void addTask(String title, String description, String status) {
    setState(() {
      tasks.add({
        'Titulo': title,
        'Descrição': description,
        'Status': status,
      });
      _taskController.clear();
    });
  }


  void updateTaskStatus(int index, String newStatus) {
    setState(() {
      tasks[index]['Status'] = newStatus;
    });
  }


  void archiveTask(int index) {
    setState(() {
      archivedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
  }


  void showArchivedTasks() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tarefas arquivadas'),
        content: ListView.builder(
          shrinkWrap: true,
          itemCount: archivedTasks.length,
          itemBuilder: (context, index) {
            final task = archivedTasks[index];
            return ListTile(
              title: Text(task['Titulo']),
              subtitle: Text(task['Descrição']),
              trailing: IconButton(
                icon: Icon(Icons.unarchive),
                onPressed: () {
                  setState(() {
                    tasks.add(task);
                    archivedTasks.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Qual sua tarefa?',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  if (_taskController.text.isNotEmpty) {
                    addTask(
                      _taskController.text,
                      '',
                      'Pra fazer',
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 86, 185, 224)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(26.0)),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ),
                ),
                child: Text('NOVA', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Pra fazer',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.where((task) => task['Status'] == 'Pra fazer').length,
                  itemBuilder: (context, index) {
                    final task = tasks.where((task) => task['Status'] == 'Pra fazer').toList()[index];
                    return ListTile(
                      title: Text(task['Titulo']),
                      subtitle: Text(task['Descrição']),
                      trailing: DropdownButton<String>(
                        value: task['Status'],
                        onChanged: (newStatus) {
                          updateTaskStatus(tasks.indexOf(task), newStatus!);
                        },
                        items: ['Pra fazer', 'Em progresso', 'Feito']
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Em progresso',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.where((task) => task['Status'] == 'Em progresso').length,
                  itemBuilder: (context, index) {
                    final task = tasks.where((task) => task['Status'] == 'Em progresso').toList()[index];
                    return ListTile(
                      title: Text(task['Titulo']),
                      subtitle: Text(task['Descrição']),
                      trailing: DropdownButton<String>(
                        value: task['Status'],
                        onChanged: (newStatus) {
                          updateTaskStatus(tasks.indexOf(task), newStatus!);
                        },
                        items: ['Pra fazer', 'Em progresso', 'Feito']
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Feito',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.where((task) => task['Status'] == 'Feito').length,
                  itemBuilder: (context, index) {
                    final task = tasks.where((task) => task['Status'] == 'Feito').toList()[index];
                    return ListTile(
                      title: Text(task['Titulo']),
                      subtitle: Text(task['Descrição']),
                      trailing: DropdownButton<String>(
                        value: task['Status'],
                        onChanged: (newStatus) {
                          updateTaskStatus(tasks.indexOf(task), newStatus!);
                        },
                        items: ['Pra fazer', 'Em progresso', 'Feito']
                            .map((status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ))
                            .toList(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: showArchivedTasks,
              icon: Icon(Icons.refresh, color: Color.fromARGB(255, 0, 0, 0)),
              label: SizedBox.shrink(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(0, 218, 218, 218)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

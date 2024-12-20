import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task(
        title: 'Tarefa 1',
        description: 'Descrição da Tarefa 1',
        column: 'A Fazer'),
    Task(
        title: 'Tarefa 2',
        description: 'Descrição da Tarefa 2',
        column: 'A Fazer'),
  ];

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Adicionar Tarefa',
              style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Título', border: OutlineInputBorder()),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Descrição', border: OutlineInputBorder()),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(
                        title: title,
                        description: description,
                        column: 'A Fazer'));
                  });
                  Navigator.of(context).pop();
                }
              },
              child:
                  Text('Salvar', style: Theme.of(context).textTheme.labelLarge),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  Text('Cancelar', style: TextStyle(color: Colors.blue[300])),
            ),
          ],
        );
      },
    );
  }

  void _editTask(Task task) {
    String title = task.title;
    String description = task.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Editar Tarefa',
              style: Theme.of(context).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: title),
                decoration: InputDecoration(
                    labelText: 'Título', border: OutlineInputBorder()),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextField(
                controller: TextEditingController(text: description),
                decoration: InputDecoration(
                    labelText: 'Descrição', border: OutlineInputBorder()),
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue[300]),
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  setState(() {
                    task.title = title;
                    task.description = description;
                  });
                  Navigator.of(context).pop();
                }
              },
              child:
                  Text('Salvar', style: Theme.of(context).textTheme.labelLarge),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  Text('Cancelar', style: TextStyle(color: Colors.blue[400])),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(Task task) {
    setState(() => tasks.remove(task));
  }

  void _moveTask(Task task, String newColumn) {
    setState(() => task.column = newColumn);
  }

  @override
  Widget build(BuildContext context) {
    List<Task> toDoTasks =
        tasks.where((task) => task.column == 'A Fazer').toList();
    List<Task> inProgressTasks =
        tasks.where((task) => task.column == 'Em Progresso').toList();
    List<Task> doneTasks =
        tasks.where((task) => task.column == 'Concluído').toList();

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Kanban App', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[300],
        actions: [IconButton(icon: Icon(Icons.add), onPressed: _addTask)],
      ),
      body: Row(
        children: [
          _buildColumn(context, 'A Fazer', toDoTasks, 'Em Progresso'),
          _buildColumn(context, 'Em Progresso', inProgressTasks, 'Concluído'),
          _buildColumn(context, 'Concluído', doneTasks, 'A Fazer'),
        ],
      ),
    );
  }

  Widget _buildColumn(
      BuildContext context, String title, List<Task> tasks, String nextColumn) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue[600])),
            ...tasks.map((task) {
              return TaskCard(
                task: task,
                onEdit: () => _editTask(task),
                onDelete: () => _deleteTask(task),
                onMove: () => _moveTask(task, nextColumn),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMove;

  TaskCard(
      {required this.task,
      required this.onEdit,
      required this.onDelete,
      required this.onMove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(task.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.edit, color: Colors.teal), onPressed: onEdit),
            IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete),
            IconButton(
                icon: Icon(Icons.arrow_forward, color: Colors.blue),
                onPressed: onMove),
          ],
        ),
      ),
    );
  }
}

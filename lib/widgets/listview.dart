import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';


class Todo_ListView extends StatelessWidget {
  final Todo todo;

  Todo_ListView(  this.todo);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:Color.fromARGB(20, 158, 158, 158),
      ),
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(vertical: 4),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(todo.data.toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14),),
          Text(todo.tarefa!,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
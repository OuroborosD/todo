import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Todo_ListView extends StatelessWidget {
  final Todo todo;
  final void Function(Todo) deletar;

  Todo_ListView(this.todo, this.deletar);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        child: Container(
        
        decoration: BoxDecoration(
          
          //borderRadius: BorderRadius.circular(12),
          color:Color.fromARGB(20, 158, 158, 158),
        ),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        //margin: EdgeInsets.symmetric(vertical: 4),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(DateFormat('dd/MM/yyyy EEEE H:mm:ss ').format(todo.data!),
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14),),
            Text(todo.tarefa!,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
          onPressed: (context){deletar(todo);},
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
         
        ],),
      ),
    );
  }
}



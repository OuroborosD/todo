import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/listview.dart';

import '../model/todo.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taferaController = TextEditingController();

  List <Todo> lista_tarefa = [];
  

  void getTarefa(){
    String tarefa = taferaController.text;
    print(tarefa);
    Todo novatarefa =  Todo(
        data: DateTime.now(),
        tarefa:tarefa);
    setState(() {
      
        lista_tarefa.add(novatarefa);
    });
     taferaController.clear();
    
    print(lista_tarefa);
  }

  bool get list_size => lista_tarefa.length >= 4; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              Text('Lista de Tarefas'),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: taferaController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder()),
                  )),
                  const SizedBox(
                    width: 8.00,
                  ),
                  ElevatedButton(
                    onPressed: getTarefa,
                    child: const Text('+',
                        style: const TextStyle(
                            fontSize: 32, 
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10)
                    ),
                  ),
                ],
              ),
              //lista
              SizedBox(height:12),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                  for( Todo tarefa in lista_tarefa)// não tem o {} no for aqui
                      
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 4),
                    //     child: ListTile(
                    //       tileColor: Color.fromARGB(10, 158, 158, 158),
                    //       leading: Icon(Icons.add_alarm),
                    //       title: Text('14/07/2022', 
                    //         style: TextStyle(
                    //           color: Colors.grey,
                    //           fontSize: 12),),
                    //       subtitle: Text(tarefa,
                    //         style: TextStyle(
                    //           fontSize: 28,
                    //           fontWeight: FontWeight.bold),) ,
                    //       onLongPress: (){
                    //         print('tarefa $tarefa');
                    //     },
                    // ),
                    //   )
                  Todo_ListView(tarefa)
                  , 
                  ],
                ),
              ),
              SizedBox(height:12),
              Row(
                children: [
                  Expanded(
                    child: Text('você possui ${lista_tarefa.length}  taferas pendentes', 
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(onPressed: ()=>{}, child: Icon(Icons.restore_from_trash))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

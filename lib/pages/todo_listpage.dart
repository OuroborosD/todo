import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taferaController = TextEditingController();

  List <String> lista_tarefa = [];

  void getTarefa(){
    String tarefa = taferaController.text;
    print(tarefa);
    setState(() {
     lista_tarefa.add(tarefa);
    });
    //taferaController.clear();// limpa o campo de texto
    print(lista_tarefa);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
            ListView(
              shrinkWrap: true,
              children: [
              for( String tarefa in lista_tarefa)// não tem o {} no for aqui
                   ListTile(
                    leading: Icon(Icons.add_alarm),
                    title: Text(tarefa),
                    subtitle: Text('14/07/2022') ,
                    onLongPress: (){
                      print(taferaController);
                  },
                )
               
              ],
            ),
            SizedBox(height:12),
            Row(
              children: [
                Expanded(
                  child: Text('você possui X taferas pendentes', 
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
    );
  }
}

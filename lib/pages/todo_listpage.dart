import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo/widgets/listview.dart';

import '../view/db_helper.dart';
import '../model/todo.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController taferaController = TextEditingController();

  List<Todo> lista_tarefa = [];
  int? posicao;
  int?id;
  int? position = 0;
  Db_view aux_db = Db_view();

  void getTarefa() async {
    String tarefa = taferaController.text;
    Todo novatarefa = Todo(data: DateTime.now(), tarefa: tarefa);

    await aux_db.saveTodo(novatarefa); // pimeiro você salva no banco de dados
    position = await aux_db.getTamanho(); // para poder verificar  tamanho do banco
    
    taferaController.clear();
    aux_db.pegarTodosTodo().then((list) {
      setState(() {
      lista_tarefa = list as List<Todo>;// tem que colocar caso de erro do tipo;
      print(lista_tarefa);
    });
    });

  }

  void deletar(Todo tarefa) {
    posicao = lista_tarefa.indexOf(tarefa);// pega a posição na tabela
    id = lista_tarefa[posicao!].id;
     aux_db.deleteTodo(id!).then((value){
        aux_db.getTamanho().then((size){
          aux_db.pegarTodosTodo().then((list){
              setState(() {
                    position = size;
                    lista_tarefa = list as List<Todo>;
                  // pega a a tarefa, e compara com a lista de objetos. para remover
                });
          });
       });
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 6),
      content: Text(
        '${tarefa.tarefa} foi removido',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          aux_db.saveTodo(tarefa).then((value){
            aux_db.getTamanho().then((size){  
              aux_db.pegarTodosTodo().then((list){
                setState(() {
                      position = size;
                      lista_tarefa = list as List<Todo>;
                    // pega a a tarefa, e compara com a lista de objetos. para remover
                });
              });
            });
          });
          
        },
      ),
    ));
  }

  void deletarTodos() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Deseja realmente apagar todas as tarefas?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Não')),
                TextButton(
                    onPressed: () async {
                      await aux_db.deleteAll();
                      position = await aux_db.getTamanho();
                      setState(() {
                        aux_db
                            .deleteAll(); // apaga todos os elementos da tabela;
                        lista_tarefa.clear();
                        aux_db.pegarTodosTodo().then((list) {
                          print(' print deleteall $list');
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Sim')),
              ],
            ));
  }
  @override
  void initState(){// serve para quando iniciar o app carregar o banco
    super.initState();
    aux_db.getTamanho().then((tamanho){
      aux_db.pegarTodosTodo().then((list){
        setState(() {
          lista_tarefa = list as List<Todo>;
          position = tamanho;
          print('carregou esse aqui ----------------');
        });
      });
    });
    
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            children: [
              Text('Lista de Tarefas'),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: taferaController,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  )),
                  const SizedBox(
                    width: 8.00,
                  ),
                  ElevatedButton(
                    onPressed: getTarefa,
                    child: const Text('+',
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(10)),
                  ),
                ],
              ),
              //lista
              SizedBox(height: 12),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo tarefa
                        in lista_tarefa) // não tem o {} no for aqui

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

                      Todo_ListView(tarefa, deletar),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'você possui $position  taferas pendentes',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                      onPressed: deletarTodos, child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

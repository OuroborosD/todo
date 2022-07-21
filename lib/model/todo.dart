class Todo{
  Todo({required this.tarefa, required this.data});
  int? id;
  String? tarefa;
  DateTime? data;

  Todo.FromMap(Map map){// transformar o mapa em dados da classe
    id = map['id'];// vai transformar a string id no nome da columna
    tarefa = map['tarefa'];
    data = DateTime.parse(map['data']);// tranforma a string em datetime
  }
  
  Map<String, dynamic> toMap(){// transforma o objeto em mapa
   Map<String, dynamic> map = {// não tem id, pois é o banco de dados que vai gerar
    'tarefa': tarefa, 
    'data': data.toString(), 
   };
   if( id != null){//
    map['id'] = id;
   }
   return map;

  }

  @override
 String toString(){// override, para mostrar otodos os dados de forma fácil
  return 'id: $id, tarefa: $tarefa, data: $data';
 }

}


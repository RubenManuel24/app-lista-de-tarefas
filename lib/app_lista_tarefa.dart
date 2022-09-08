 import 'package:flutter/material.dart';
 import 'package:path_provider/path_provider.dart';
 import 'dart:io';
 import 'dart:convert';
 import 'dart:async';

 class HomeApp extends StatefulWidget {
   HomeApp({Key? key}) : super(key: key);
 
   @override
   State<HomeApp> createState() => _HomeAppState();
 }
 
 class _HomeAppState extends State<HomeApp> {

  TextEditingController _controller = TextEditingController();
  List _lista =[];

  Map<String, dynamic> _itemCapturado = Map();

  Widget criarLista(context, index){

    //final item = _lista[index]["condicao"]

    return Dismissible(
      
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()), 
      direction: DismissDirection.endToStart,
      onDismissed: (direcao){

        //capturar a item eliminado
         _itemCapturado = _lista[index];

        //Remove item da lista
        _lista.removeAt(index);
        _salvarDado();

         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Tarefa apagada", style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.black)),
          elevation: 20,
          duration: Duration(seconds: 3),  
          backgroundColor: Color.fromARGB(255, 97, 92, 92),
          action: SnackBarAction(
                    label: "Desfazer",
                    textColor: Color.fromARGB(255, 4, 16, 197),
                    onPressed: (){
                      
                     setState(() {
                       _lista.insert(index, _itemCapturado);
                     });

                       _salvarDado();

                    },
                    ),
                 ));

      },
      background: Container(
        padding: EdgeInsets.all(18),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          Icon(Icons.delete,
                color: Colors.white,
          ),
        ]),
      ),
      child: CheckboxListTile(
          value: _lista[index]["condicao"], 
          onChanged: (condicao){
            setState(() {
                _lista[index]["condicao"] = condicao;
            }); 
            },
            title: Text(_lista[index]["titulo"].toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          )
      );
  }

  Future<File> _caminhoArquiv() async {

   final dir = await getApplicationDocumentsDirectory();
         return File("${dir.path}/arquivoteste.json");
  }
   
     _salvarTarefa(){
       
       String textoDigitado = _controller.text;

       Map<String, dynamic> dado = Map();
      dado["titulo"] = textoDigitado;
      dado["condicao"] = false;

       setState(() {
          _lista.add(dado);
       });
       
       _controller.text  = "";
       
       _salvarDado();

     }

    _salvarDado() async {
     
      final arquivo = await _caminhoArquiv();
      var dadosJson = json.encode(_lista);

      arquivo.writeAsString(dadosJson);
    
    }

    _leitura() async {

      try{

        var arquivo = await _caminhoArquiv();
         return arquivo.readAsString();
      }
      catch(e){
         return null;
      }
    }

    @override
  void initState() {
    super.initState();

    _leitura().then(
      (dados){
        setState(() {
          _lista = json.decode(dados);
        });
      }
    );
  }   

   @override
   Widget build(BuildContext context) {
   
    // cada vez que é executado esse millisecondsSinceEpoch tem valor diferente
    // e por isso é bom para ser uma chave do item no metodo criarLista()
    //print("Numero: " + DateTime.now().millisecondsSinceEpoch.toString());

     return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.black,
      ),
      body: Container(
                 child: Column(
                  children: <Widget>[
                      Expanded(child: ListView.builder(
              itemBuilder: criarLista,
                
               /*
                  return ListTile(
                    title: Text(_lista[index]["titulo"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ), 
                  );
                */
              itemCount: _lista.length),),
                  ],
                 )
              ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed:(){
            showDialog(
              context: context, 
              builder: (context){
                 return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    elevation: 10,
                    content: TextField(
                      controller: _controller,
                      autocorrect: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text("Digite a Tarefa"),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          _salvarTarefa();
                          Navigator.pop(context);
                        }, 
                        child: Text("Salvar")
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text("Cancelar")
                     )
                    ],
                 );
              });
        },
        backgroundColor: Color.fromARGB(255, 5, 3, 145),
        elevation: 30,
        child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          elevation: 5,
          child: Row(
            children: [
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.menu),
                color: Color.fromARGB(255, 5, 3, 145),
                )
            ],
          ),
          shape: CircularNotchedRectangle(),
        ),
     );
   }
 }
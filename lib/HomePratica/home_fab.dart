import 'package:flutter/material.dart';
class HomeFAB extends StatefulWidget {
  HomeFAB({Key? key}) : super(key: key);

  @override
  State<HomeFAB> createState() => _nameState();
}

class _nameState extends State<HomeFAB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.purple,
        title: Text("FloatingActionButton"),),
      body: Text(" Conteudo"),
      floatingActionButtonLocation: 
      FloatingActionButtonLocation.centerDocked,
      //floatingActionButton: FloatingActionButton
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        isExtended: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 20,
        icon: Icon(Icons.shopping_cart),
        label: Text("Adicionar"),
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.vertic)
        ),*/
        //mini: true,
        /*icon:Icon(Icons.add),
        onPressed: (){
          print("Resultado botão pressionado!");
        }*/
        
        ),
        bottomNavigationBar: BottomAppBar(
          //shape: CircularNotchedRectangle(),
          color: Colors.purple,
         child: Row(
          children: <Widget>[
            IconButton(
              color: Colors.red,
              onPressed:(){},
               icon: Icon(Icons.menu))
          ],
         )
         ),
    ); 
  }
}

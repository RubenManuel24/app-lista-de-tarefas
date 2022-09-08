import 'package:flutter/material.dart';
class HomePratica extends StatefulWidget {
  HomePratica({Key? key}) : super(key: key);

  @override
  State<HomePratica> createState() => _HomePraticaState();
}

class _HomePraticaState extends State<HomePratica> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade100,
        title: Text("Agenda"),
      ),
      body: Text("Algo Qualquer"),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //floatingActionButton: FloatingActionButton
      floatingActionButton: FloatingActionButton.extended(
       onPressed: (){},
        //child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent.shade700,
        //mini: true,
        elevation: 15,
        label: Text("Criar Alarme"),
        icon: Icon(Icons.alarm_outlined),
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),*/
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.red.shade100,
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.menu),
                color: Colors.greenAccent.shade700,
                ),
            ],
          ),
          //shape: CircularNotchedRectangle(),
        ),
    );
  }
}
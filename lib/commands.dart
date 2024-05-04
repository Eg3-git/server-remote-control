import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'classes.dart';

class ActionPage extends StatefulWidget {

  const ActionPage({super.key, required this.title});
  final String title;


  @override
  ActionState createState() => ActionState();

}

class ActionState extends State<ActionPage> with SingleTickerProviderStateMixin {

  List<Command> commands = [Command("Wake", Server("x")), Command("Sleep", Server("y")), Command("Backup", Server("z"))];
  int currentPageIndex = 1;
  final _formKey = GlobalKey<FormState>();
  List<Server> servers = [
    Server("xxx.xxx.x.xx"),
    Server("yyy.yyy.y.yy")
  ];
  Server? _selectedObject;
  Server? dummyServer;
  String dummyName = "";

  void nothing() {}

  Future popup() {
    return showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.deepPurple,
          content: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                right: -40,
                top: -40,
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("Add a command")),

                    Padding(
                        padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black, // Set your desired background color
                        borderRadius: BorderRadius.circular(10.0), // Optional: Add border radius for rounded corners
                      ),

                    child: DropdownButtonFormField<Server>(

                      value: _selectedObject,
                      hint: Text("Select Server", style: TextStyle(color: Colors.grey),),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedObject = newValue;
                        });
                      },
                        onSaved: (s) {setState(() {

                          dummyServer = s;
                        });},
                        validator: (value) {
                          if (value == null) {
                            return "ERROR";
                          }
                          return null;
                        },
                      items: servers.map<DropdownMenuItem<Server>>((Server s) {
                        return DropdownMenuItem<Server>(value: s, child: Text(s.address, style: TextStyle(color: Colors.white),));
                      },
                    ).toList()
                    ),),),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(

                        textAlignVertical: TextAlignVertical.center,

                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.grey, backgroundColor: Colors.black),
                          filled: true,
                          fillColor: Colors.black,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

                          ),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "ERROR";
                          }
                          return null;
                        },
                        onSaved: (name) {setState(() {
                          dummyName = name!;
                        });},),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text('Submitß'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              commands.add(Command(dummyName, dummyServer!));
                            });
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget columnBuilder() {
    return Padding(padding: const EdgeInsets.only(top: 40), child:

    Column(
      children: rowBuilder(),
    ));
  }

  List<Widget> rowBuilder() {
    List<Widget> rows = [];
    for (Command c in commands) {
      rows.add(Row(
        children: [
          const Spacer(),
          Expanded(flex: 6, child: Text(c.title)),
          const Spacer(),
          Expanded(flex: 3,
              child: ElevatedButton(onPressed: nothing, child: const Text("Launch"))),
          const Spacer(),
          const Icon(Icons.settings, color: Colors.white,),
          const Spacer()
        ],


      ));
      rows.add(const SizedBox(height: 10,));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(child: Center(child: columnBuilder())),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.add),
          onPressed: popup,
        )
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

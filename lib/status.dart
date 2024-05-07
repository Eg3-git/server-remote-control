import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'commands.dart';
import 'classes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> pages = [const MyHomePage(title: "Status"), const ActionPage(title: "Actions")];
  final _formKey = GlobalKey<FormState>();
  int dropdownValue = -1;

  List<Server> servers = [
    Server("xxx.xxx.x.xx", "22"),
    Server("yyy.yyy.y.yy", "80")
  ];
  List<String> dummyData = ["", ""];

  void nothing() {}

  Future popup({bool editMode=false, Server? serverToEdit}) {
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
                    Padding(
                        padding: const EdgeInsets.all(8),
                    child: editMode ? const Text("Edit Server") : const Text("Add a Server")),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(

                        textAlignVertical: TextAlignVertical.center,
                        initialValue: editMode ? serverToEdit?.address : "",

                        decoration: InputDecoration(
                          labelText: "Server Address",
                          labelStyle: const TextStyle(color: Colors.grey, backgroundColor: Colors.black),
                          filled: true,
                          fillColor: Colors.black,

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),

                          ),),
                      validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter server IP or URL";
                          }
                          return null;
                      },
                      onSaved: (ad) {setState(() {
                        dummyData[0] = ad!;
                      });},),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(

                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        maxLength: 5,
                        initialValue: editMode ? serverToEdit?.port : "",

                        decoration: InputDecoration(
                          labelText: "Port",
                          labelStyle: const TextStyle(color: Colors.grey, backgroundColor: Colors.black),
                          filled: true,
                          fillColor: Colors.black,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

                          ),),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the port your server is listening on";
                          } else {
                            int valueAsInt = 0;
                            try {valueAsInt = int.parse(value);} on Exception catch (_) {return "Please enter a valid port";}
                            if (valueAsInt < 0 || valueAsInt > 65535) {return "Port must be in range 0 -> 65535";}
                          }
                          return null;
                        },
                        onSaved: (p) {setState(() {
                          dummyData[1] = p!;
                        });},),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (editMode) {
                              serverToEdit?.address = dummyData[0];
                              serverToEdit?.port = dummyData[1];
                            } else {
                              servers.add(Server(dummyData[0], dummyData[1]));
                            }
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
    for (Server s in servers) {
      rows.add(Row(
        children: [
          const Spacer(),
          Expanded(flex: 7, child: Text("${s.address}:${s.port}")),
          const Spacer(),
          Expanded(flex: 2, child: s.isOnline ? const Text("Online") : const Text("Offline")),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings),
            color: Colors.white, onPressed: () => popup(editMode: true, serverToEdit: s),
          ),
          const Spacer()
        ],
      ));
      rows.add(const SizedBox(height: 10));
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
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

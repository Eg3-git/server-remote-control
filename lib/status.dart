import 'package:flutter/material.dart';
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
    Server("xxx.xxx.x.xx"),
    Server("yyy.yyy.y.yy")
  ];

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
                    child: Text("Add a server")),

                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(

                        textAlignVertical: TextAlignVertical.center,

                        decoration: InputDecoration(
                          labelText: "Server Address",
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
                      onSaved: (ad) {setState(() {
                        servers.add(Server(ad!));
                      });},),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text('Submitß'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
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
          Expanded(flex: 7, child: Text(s.address)),
          const Spacer(),
          Expanded(flex: 2, child: s.isOnline ? const Text("Online") : const Text("Offline")),
          const Spacer(),
          const Icon(
            Icons.settings,
            color: Colors.white,
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

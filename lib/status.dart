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

  final List<Widget> pages = [const MyHomePage(title: "Status"), const ActionPage(title: "Actions")];

  List<Server> servers = [
    Server("xxx.xxx.x.xx"),
    Server("yyy.yyy.y.yy")
  ];

  void nothing() {}

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
        floatingActionButton: PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case "1":
                nothing();
                break;
              case "2":
                nothing();
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: '1',
              child: Text('Increase'),
            ),
            const PopupMenuItem<String>(
              value: '2',
              child: Text('Decrease'),
            ),
            // Add more PopupMenuItems for other options if needed
          ],
          child: const Icon(Icons.add),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

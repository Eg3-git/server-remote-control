import 'package:flutter/material.dart';
import 'actions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Widget> pages = [const MyHomePage(title: "Status"), const ActionPage(title: "Actions")];

  List<List<String>> servers = [
    ["xxx.xxx.x.xx", "Online"],
    ["yyy.yyy.y.yy", "Offline"]
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
    for (List<String> ipPair in servers) {
      rows.add(Row(
        children: [
          const Spacer(),
          Expanded(flex: 7, child: Text(ipPair[0])),
          const Spacer(),
          Expanded(flex: 2, child: Text(ipPair[1])),
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


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

  Widget rowBuilder() {
    return Column(
      children: [
        for (List<String> ip_pair in servers)
          Row(
            children: [
              Text(ip_pair[0]),
              Text(ip_pair[1]),
              const Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(child: Center(child: rowBuilder())),
        floatingActionButton: PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case "1":
                _incrementCounter();
                break;
              case "2":
                _decrementCounter();
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

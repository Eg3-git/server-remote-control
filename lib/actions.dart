import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {

  const ActionPage({super.key, required this.title});
  final String title;


  @override
  ActionState createState() => ActionState();

}

class ActionState extends State<ActionPage> with SingleTickerProviderStateMixin {

  List<String> actions = ["Wake", "Sleep", "Backup"];
  int currentPageIndex = 1;

  void nothing() {}

  Widget rowBuilder() {
    return Column(
      children: [
        for (String action in actions) Row(
          children: [
            Text(action),
            ElevatedButton(onPressed: nothing, child: Text("Launch")),
            const Icon(Icons.delete, color: Colors.white,)
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
                nothing();
              case "2":
                nothing();
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

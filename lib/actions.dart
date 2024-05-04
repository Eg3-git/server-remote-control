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

  Widget columnBuilder() {
    return Padding(padding: const EdgeInsets.only(top: 40), child:

    Column(
      children: rowBuilder(),
    ));
  }

  List<Widget> rowBuilder() {
    List<Widget> rows = [];
    for (String action in actions) {
      rows.add(Row(
        children: [
          const Spacer(),
          Expanded(flex: 6, child: Text(action)),
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

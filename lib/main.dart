// main.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:server_remote_control/classes.dart';
import 'package:server_remote_control/hive_helper.dart';
import 'package:server_remote_control/sqflite_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'commands.dart';
import 'status.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StorageHelper storageHelper;

  if (kIsWeb) {
    await Hive.initFlutter();
    storageHelper = HiveHelper();
  } else {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    storageHelper = SqfliteHelper();
  }

  runApp(MyApp(storageHelper: storageHelper));
}

class MyApp extends StatelessWidget {
  final StorageHelper storageHelper;

  const MyApp({super.key, required this.storageHelper});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bottom Navigation Example',
      theme: theme(context),
      home: BottomNavigation(storageHelper: storageHelper),
    );
  }
}

class BottomNavigation extends StatefulWidget {
  final StorageHelper storageHelper;

  const BottomNavigation({super.key, required this.storageHelper});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MyHomePage(
        title: 'Server Status',
        storageHelper: widget.storageHelper,
      ),
      ActionPage(
        title: 'Commands',
        storageHelper: widget.storageHelper,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Commands',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

import 'package:hive/hive.dart';

import 'classes.dart';

class HiveHelper implements StorageHelper {
  static final HiveHelper _instance = HiveHelper._internal();

  factory HiveHelper() {
    return _instance;
  }

  HiveHelper._internal();

  Future<Box<Map>> _getBox() async {
    return await Hive.openBox<Map>('myBox');
  }

  @override
  Future<void> insertServer(Server s) async {
    final box = await _getBox();
    await box.put('s_${s.address}', s.toMap());
  }

  @override
  Future<void> insertCommand(Command c) async {
    final box = await _getBox();
    await box.put('c_${c.title}', {
      'title': c.title,
      'serverId': c.serverId.toMap(),
    });
    print('Command inserted: ${c.toMap()}'); // Add this lin
  }

  @override
  Future<List<Server>> getServers() async {
    final box = await _getBox();
    final Map<dynamic, dynamic> rawItems = box.toMap();
    return rawItems.values
        .where((element) =>
            element.containsKey('address') && element.containsKey('port'))
        .map((e) => Server.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  @override
  Future<List<Command>> getCommands() async {
    final box = await _getBox();
    final Map<dynamic, dynamic> rawItems = box.toMap();
    return rawItems.values
        .where((element) =>
            element.containsKey('title') && element.containsKey('serverId'))
        .map((e) {
      final serverMap = Map<String, dynamic>.from(e['serverId'] as Map);
      return Command(
        title: e['title'],
        serverId: Server.fromMap(serverMap),
      );
    }).toList();
  }
}

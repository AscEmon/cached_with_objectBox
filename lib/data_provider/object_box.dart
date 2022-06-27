import 'dart:core';
import 'dart:io';
import 'package:caching_test/mvc/module_name/model/person.dart';
import 'package:caching_test/mvc/module_name/model/build_runner_file/objectbox.g.dart';


class ObjectBox {
  late final Store _store;
  late final Box<PersonElement> _userBox;

  ObjectBox._init(this._store) {
    _userBox = Box<PersonElement>(_store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    
    if (Sync.isAvailable()) {
      /// Or use the ip address of your server
      //final ipSyncServer = '123.456.789.012';
      final ipSyncServer = Platform.isAndroid ? '10.0.2.2' : '127.0.0.1';
      final syncClient = Sync.client(
        store,
        'ws://$ipSyncServer:9999',
        SyncCredentials.none(),
      );
      syncClient.connectionEvents.listen(print);
      syncClient.start();
    }

    return ObjectBox._init(store);
  }
  
  PersonElement? getPersonElement(int id) => _userBox.get(id);

  Stream<List<PersonElement>> getPersonElements() => _userBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  List<PersonElement> getPersonList() {
    return _userBox.query().build().find();
  }

  int insertPerson(PersonElement user) => _userBox.put(user);

  bool deletePersonElement(int id) => _userBox.remove(id);
}

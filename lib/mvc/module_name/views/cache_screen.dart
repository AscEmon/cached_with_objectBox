import 'package:caching_test/main.dart';
import 'package:caching_test/mvc/module_name/controller/cache_controller.dart';
import 'package:caching_test/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cacheProvider =
    ChangeNotifierProvider<CacheController>((ref) => CacheController());

class CacheScreen extends StatelessWidget {
  const CacheScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caching Test"),
        actions: [
          GestureDetector(
            onTap: () async {
              List personlist = await objectBox.getPersonList();
              personlist.length.log();
              "call".log();
            },
            child: Icon(Icons.check_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, ref, snapshot) {
              final cacheController = ref.watch(cacheProvider);
              return Expanded(
                child: cacheController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: cacheController.person.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              tileColor: Colors.cyanAccent,
                              title: Text(
                                cacheController.person[index].name.toString(),
                              ),
                            ),
                          );
                        },
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}

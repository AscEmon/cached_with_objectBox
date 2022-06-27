import 'dart:io';
import 'package:caching_test/data_provider/api_client.dart';
import 'package:caching_test/main.dart';
import 'package:caching_test/mvc/module_name/model/person.dart';
import 'package:caching_test/utils/enum.dart';
import 'package:caching_test/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as d;
import 'package:objectbox/internal.dart';

class CacheController extends ChangeNotifier {
  CacheController() {
    getPerson();
  }

  List<PersonElement> person = [];
  final ApiClient apiclient = ApiClient();
  final map = Map<String, dynamic>();
  bool isLoading = true;

  getPerson() async {
    try {
      isLoading = true;
      await apiclient.request(
          method: Method.GET,
          url: "http://192.168.0.104:5500/api/person1.json",
          onSuccessFunction: (d.Response<dynamic> response) {
            if (response.data != null) {
              var data = Person.fromJson(response.data);
              if (data.statusCode == 200) {
                if (data.person != null) {
                  person.addAll(data.person!.toList());

                  /**
                   * First time Data is cached
                   * when internet is available
                   **/
                  // person.forEach((element) async {
                  //   await objectBox.insertPerson(element);
                  // });
                  objectBox.setPersonList(data.person!.toList());
                }
              }
            }
            return null;
          });
    } on SocketException catch (e) {
      /**
       * Cached Data is get
       * when internet is not available
       */
      person.clear();
      person.addAll(objectBox.getPersonList().toSet());
    } on Exception catch (e) {
      e.log();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

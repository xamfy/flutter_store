import 'package:flutter_store/models/store.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Store>> getStores(http.Client client) async {
  var response = await client.get("http://switchip.herokuapp.com/stores");
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    var jsonData = json.decode(response.body);

    List<Store> stores = [];

    for (var u in jsonData) {
      Store store = Store.fromJson(u);

      stores.add(store);
    }
    return stores;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load stores');
  }
}

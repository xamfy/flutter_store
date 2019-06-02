import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/store.dart';

Future<Stream<Store>> getStores() async {
  final String url = 'http://switchip.herokuapp.com/stores';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Store.fromJson(data));
}

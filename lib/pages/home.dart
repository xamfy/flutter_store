import 'package:flutter/material.dart';
import '../repository/store_repository.dart';
import '../models/store.dart';
import '../widgets/store_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Store> _stores = <Store>[];

  @override
  void initState() {
    super.initState();
    listenForStores();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Stores'),
        ),
        body: ListView.builder(
          itemCount: _stores.length,
          itemBuilder: (context, index) => StoreTile(_stores[index]),
        ),
      );

  void listenForStores() async {
    final Stream<Store> stream = await getStores();
    stream.listen((Store store) => setState(() => _stores.add(store)));
  }
}

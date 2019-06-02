import 'package:flutter/material.dart';
import '../models/store.dart';

class StoreTile extends StatelessWidget {
  final Store _store;
  StoreTile(this._store);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            title: Text(_store.entityName),
            subtitle: Text(_store.county),
            // leading: Container(
            //     margin: EdgeInsets.only(left: 6.0),
            //     child: Image.network(
            //       'https://source.unsplash.com/random',
            //       height: 50.0,
            //       fit: BoxFit.fill,
            //     )),
          ),
          Divider()
        ],
      );
}

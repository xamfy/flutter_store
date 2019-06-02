import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/store.dart';
import 'widgets/color_loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Store',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(title: 'Stores'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];
  Future<List<Store>> _getStores() async {
    var data = await http.get("http://switchip.herokuapp.com/stores");

    var jsonData = json.decode(data.body);

    List<Store> stores = [];

    for (var u in jsonData) {
      Store store = Store.fromJson(u);

      stores.add(store);
    }

    print(stores.length);

    return stores;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getStores(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Center(
                child: ColorLoader(
                  colors: colors,
                  duration: Duration(milliseconds: 1200),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Card(
                      // margin: new EdgeInsets.symmetric(
                      //     horizontal: 10.0, vertical: 8.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16.0),
                      ),
                      elevation: 2.0,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              child: Image.network(
                                  "https://source.unsplash.com/random/400x400"),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data[index].entityName,
                                      style: Theme.of(context).textTheme.title),
                                  SizedBox(height: 10.0),
                                  Text(snapshot.data[index].county),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(snapshot.data[index].city),
                                      // Text(snapshot.data[index].state),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(snapshot.data[index])));
                        },
                      ),
                      // child: Container(
                      //   child: ListTile(
                      //     // leading: CircleAvatar(
                      //     //   backgroundImage:
                      //     //       NetworkImage(snapshot.data[index].picture),
                      //     // ),
                      //     leading: Container(
                      //         margin: EdgeInsets.only(left: 6.0),
                      //         child: Image.network(
                      //           'https://source.unsplash.com/random/400x400',
                      //           height: 50.0,
                      //           fit: BoxFit.fill,
                      //         )),
                      //     title: Text(snapshot.data[index].entityName),
                      //     subtitle: Text(snapshot.data[index].county),
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           new MaterialPageRoute(
                      //               builder: (context) =>
                      //                   DetailPage(snapshot.data[index])));
                      //     },
                      //   ),
                      // ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Store store;

  DetailPage(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(store.entityName),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/color_loader.dart';
import 'package:flutter_store/resources/store_provider.dart';

import 'detail.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      // appBar: new AppBar(
      //   title: new Text(widget.title),
      // ),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Stores List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getStores(http.Client()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].county,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        ', ' + snapshot.data[index].state,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                        ),
                                      ),
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

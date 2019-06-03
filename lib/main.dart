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
        primarySwatch: Colors.grey,
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
                                      // Text(snapshot.data[index].city),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 10.0),
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(
                              "https://source.unsplash.com/random/400x400"),
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.all(40.0),
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(58, 66, 80, .8)),
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 90.0,
                        ),
                        Text(
                          store.entityName,
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          store.city + ",  " + store.state,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )
                      ],
                    )),
                  ),
                  Positioned(
                    left: 15.0,
                    top: 25.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "County : " + store.county,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "License number : " + store.licenseNumber.toString(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Operation type : " + store.operationType,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Establishment type : " + store.establishmentType,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Entity name : " + store.entityName,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "DBA name : " + store.dbaName,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Street number : " + store.streetNumber.toString(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Street name : " + store.streetName,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "City : " + store.city,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "State : " + store.state,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Zip code : " + store.zipCode.toString(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Square footage : " + store.squareFootage.toString(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

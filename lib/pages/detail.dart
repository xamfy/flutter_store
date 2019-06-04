import 'package:flutter/material.dart';
import 'package:flutter_store/models/store.dart';

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

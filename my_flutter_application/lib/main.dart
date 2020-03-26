import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],
            accentColor: Colors.cyan[600]
        ),
        home: MyApp()
    )
);

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  String name, description;
  double price;

  getName(name) {
    this.name = name;
    print(this.name);
  }

  getDescription(description) {
    this.description = description;
    print(this.description);
  }

  getPrice(price) {
    this.price = double.parse(price);
    print(this.price);
  }

  void createData() async {
    final databaseReference = Firestore.instance;

    Map<String, dynamic> dish = {
      "name": name,
      "description": description,
      "price": price
    };
    await databaseReference.collection("Dishes")
        .document(name)
        .setData(dish);
  }

  //read one
  void readData() {
    final databaseReference = Firestore.instance;
    databaseReference
        .collection("Dishes")
        .where('name', isEqualTo: name)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}')); //data["name"]
    });
  }

  //read all
//  void readData() {
//    final databaseReference = Firestore.instance;
//    databaseReference
//        .collection("Dishes")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });
//  }

  updateData() async {
    final databaseReference = Firestore.instance;

    Map<String, dynamic> dish = {
      "name": name,
      "description": description,
      "price": price
    };
    await databaseReference.collection("Dishes")
        .document(name)
        .setData(dish);
  }

  deleteData() async {
    try {
      final databaseReference = Firestore.instance;
      databaseReference
          .collection("Dishes")
          .where('name', isEqualTo: name)
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.first.reference.delete()
            .whenComplete(() => name + " deleted");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase CRUD"),
        ),
        body:
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    hintText: "Name"
                ),
                onChanged: (String name){
                  getName(name);
                },
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Description"
                ),
                onChanged: (String description){
                  getDescription(description);
                },
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Price"
                ),
                onChanged: (String price){
                  getPrice(price);
                },
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text("Create"),
                          onPressed: (){
                            createData();
                          }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                          child: Text("Read"),
                          onPressed: (){
                            readData();
                          }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                          color: Colors.orange,
                          child: Text("Update"),
                          onPressed: (){
                            updateData();
                          }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: RaisedButton(
                          color: Colors.red,
                          child: Text("Delete"),
                          onPressed: (){
                            deleteData();
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                      child: Text("Name")
                  ),
                  Expanded(
                      child: Text("Description")
                  ),
                  Expanded(
                      child: Text("Price")
                  )
                ],
              ),
              StreamBuilder(
                  stream: Firestore.instance.collection("Dishes").snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index){
                            DocumentSnapshot ds = snapshot.data.documents[index];
                            return Row(
                              textDirection: TextDirection.ltr,
                              children: <Widget>[
                                Expanded(
                                    child: Text(ds["name"].toString())
                                ),
                                Expanded(
                                    child: Text(ds["description"].toString())
                                ),
                                Expanded(
                                    child: Text(ds["price"].toString())
                                ),
                              ],
                            );
                          }
                      );
                    }
                    else{
                      return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
              )
            ],
          ),
        )
    );
  }
}


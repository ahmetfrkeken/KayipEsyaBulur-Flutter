import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Firestore _firestore = Firestore.instance;

class deneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("deneme"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Kullanıcılar').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text("Veriler getiriliyor...");
            return ListView(
                children: snapshot.data.documents.map((doc) => ListTile(
                      title: Text(doc['ad']),
                      subtitle: Text(doc['e-mail']),
                    )).toList());
          }),
    );
  }
}


/*
Scaffold(
      appBar: AppBar(
        title: Text("deneme"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Kullanıcılar").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text("Veriler getiriliyor...");
          return Column(
            children: <Widget>[
              Text(snapshot.data.documents[0]['ad']),
              Text(snapshot.data.documents[0]['e-mail']),
              Text(snapshot.data.documents[1]['ad']),
            ],
          );
        },
      ),
    );
 */

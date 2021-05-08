import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kayip_bulur/FlutterToast.dart';
import 'homePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _firestore = Firestore.instance;
class MainScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFB1F2B36),
        child: AppContainer(),
      ),
    );
  }
}

class AppContainer extends StatefulWidget {
  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final picker = ImagePicker();
  File _secilenResim;


  final List<String> menuItems = [
    "Mesajlar",
    "Ayarlar",
    "Kayıp Çocuklar",
    "Kayıp Hayvanlar",
    "Elektronik Eşyalar",
    "Aksesuarlar"
  ];
  final List<String> IconName = [
    "mesaj",
    "ayarlar",
    "cocuk",
    "hayvan",
    "elektronik",
    "aksesuar"
  ];



  bool fotovisible = false;

  bool sideBarOpen = false;

  double yOffset = 0;

  double xOffset = 60;

  int selectedMenuItem = 0;


  void setSidebarState() {
    setState(() {
      xOffset = sideBarOpen ? 265 : 60;
    });
  }

/*
void _adSoyadResimSorgula() async{
  var isim_sorgula = await _firestore.collection("users").where("ad",isEqualTo: "${HomePage.kullanici_adi}").getDocuments();

  debugPrint("deneme " + isim_sorgula.toString());
}
*/

/*StreamBuilder(
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
    );
       */

  void fotodurumu() {
    setState(() {
      if (fotovisible) {
        fotovisible = false;
      } else {
        fotovisible = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff2A2E43),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 100, right: 160),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                fotodurumu();
                              },
                              child: Image.asset("assets/images/user.png"),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Ahmet Faruk Eken",
                              style: TextStyle(
                                  fontFamily: "Ignite The Light",
                                  color: Color(0xffAFB1CC),
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Expanded(
                        child: new ListView.builder(
                          itemCount: menuItems.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              sideBarOpen = false;
                              setSidebarState();
                              selectedMenuItem = index;
                            },
                            child: MenuItem(
                              itemIcon: IconName[index],
                              itemText: menuItems[index],
                              selected: selectedMenuItem,
                              position: index,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: GestureDetector(
                      onTap: () {
                        sideBarOpen = false;
                        setSidebarState();
                        selectedMenuItem = menuItems.length + 1;
                        cikisYap();
                        Navigator.pop(context);
                      },
                      child: MenuItem(
                        itemIcon: "logout",
                        itemText: "Çıkış",
                        selected: selectedMenuItem,
                        position: menuItems.length + 1,
                      ),
                    )),
                  ],
                ),
              ),
              AnimatedContainer(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 400),
                transform: Matrix4.translationValues(xOffset, yOffset, 1.0),
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(20),
                              child: Icon(Icons.menu),
                            ),
                            onTap: () {
                              sideBarOpen = !sideBarOpen;
                              setSidebarState();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                child: Opacity(
                    opacity: 1,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 200,
                            width: 350,
                            color: Colors.black38,
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      child: GestureDetector(
                                        child: Image.asset(
                                            "assets/images/back.png"),
                                        onTap: () {
                                          fotodurumu();
                                        },
                                      ),
                                      padding: EdgeInsets.only(
                                          left: 300, bottom: 10),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        FlatButton(
                                          child: galeri(),
                                          onPressed: _galeriResimUpload,
                                        ),
                                        FlatButton(
                                          child: kamera(),
                                          onPressed: _kameraResimUpload,
                                        )
                                      ],
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                visible: fotovisible,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _galeriResimUpload() async {
    var resim = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _secilenResim = File(resim.path);
    });
    var ref = FirebaseStorage.instance.ref().child("kullanıcılar").child("${HomePage.kullanici_adi}.png");
    StorageUploadTask uploadTask = await ref.putFile(_secilenResim);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    debugPrint("Upload edilen resmin url i : $url");
  }

  void _kameraResimUpload() async {
    var resim = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _secilenResim = File(resim.path);
    });
  }

  Widget galeri() {
    return Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Color(0xff2A2E43),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Galeriden Eklemek İçin Tıkla",
                style: TextStyle(
                    fontFamily: "Ignite The Light",
                    color: Color(0xffAFB1CC),
                    fontSize: 15)),
          ],
        ));
  }

  Widget kamera() {
    return Container(
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Color(0xff2A2E43),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Kameradan Eklemek İçin Tıkla",
                style: TextStyle(
                    fontFamily: "Ignite The Light",
                    color: Color(0xffAFB1CC),
                    fontSize: 15)),
          ],
        ));
  }

  void cikisYap() async {
    if (await _auth.currentUser() != null) {
      _auth
          .signOut()
          .then((data) => debugPrint("Kullanıcı Çıkış Yaptı"))
          .catchError((e) => debugPrint("Çıkış yaparken hata oluştu. $e"));
    } else {
      debugPrint("Şuanda giriş yapmış bir kullanıcı yok.");
    }
  }
}

class MenuItem extends StatelessWidget {
  final String itemText;
  final String itemIcon;
  final int selected;
  final int position;

  MenuItem({this.itemText, this.itemIcon, this.selected, this.position});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: selected == position ? Color(0xff273A5E0) : Color(0xff2A2E43),
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              "assets/images/${itemIcon}.png",
              width: 15,
              height: 15,
            ),
            padding: const EdgeInsets.all(20),
          ),
          Container(
            child: Text(
              itemText,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            padding: const EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }
}





/*
StreamBuilder(
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
 */
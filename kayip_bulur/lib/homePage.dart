import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kayip_bulur/ForgetPassword.dart';
import 'package:kayip_bulur/SingUpScreen.dart';
import 'package:kayip_bulur/mainScreen.dart';
import 'OnBoardColorClipper.dart';
import 'SingUpScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String kullanici_adi = "YOK";
  static String sifre = "Yok";
  static String ad = "Yok";
  static String soyad = "Yok";

  static List<String> Uyeler =[

  ];


  BuildContext context = null;
  @override
  Widget build(BuildContext context) {
    this.context=context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: OnBoardColorClipper(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 425,
                      color: Color(0xff2A2E43),
                      child: Image.asset(
                        "assets/images/asilicon.png",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 60,
                      child: Text(
                        "Kayıp",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: "Ignite The Light",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 110,
                      child: Text(
                        "Bulur",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: "Ignite The Light",
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 30,
                bottom: 30,
                child: Text(
                  "GİRİŞ",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xffcbcbcb),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          buildUsername(),
          SizedBox(
            height: 25,
          ),
          buildPassword(),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                          child: Text(
                            "Şifremi Unuttum",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPassword()));
                          }),
                      FlatButton(
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          }),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: GestureDetector(
                    child: RaisedButton(
                      child: Text(
                        "GİRİŞ",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xff2A2E43),
                      onPressed: _emailSifreLogin,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  void _emailSifreLogin() {
    _auth
        .signInWithEmailAndPassword(email: kullanici_adi, password: sifre)
        .then((oturumAcmisKullanici) {
      if (oturumAcmisKullanici.user.isEmailVerified != true) {
        Fluttertoast.showToast(msg: "Lütfen Mailinizi Onaylayın");
        _auth.signOut();
      } else {
        Fluttertoast.showToast(msg: "Hoşgeldiniz...");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen()));
      }
    }).catchError((Hata) {
      print(Hata.toString());
      Fluttertoast.showToast(msg: "Kullanıcı Adı veya Şifre Hatalı...");
    });
  }


  Widget buildUsername() {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Color(0xffe7e7e7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: 4, left: 24, right: 16),
        child: TextField(
          onChanged: (veri) {
            kullanici_adi = veri;
          },
          decoration: InputDecoration(
              hintText: "Kullanıcı Adı",
              hintStyle: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
              ),
              enabledBorder: InputBorder.none,
              suffixIcon: Icon(Icons.account_circle)),
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Container(
      width: double.infinity,
      height: 45,
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Color(0xffe7e7e7),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: 4, left: 24, right: 16),
        child: TextField(
          onChanged: (veri) {
            sifre = veri;
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Şifre",
              hintStyle: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
              ),
              enabledBorder: InputBorder.none,
              suffixIcon: Icon(Icons.remove_red_eye)),
        ),
      ),
    );
  }
}

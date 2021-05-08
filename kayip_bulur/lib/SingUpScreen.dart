import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayip_bulur/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

final Firestore _firestore = Firestore.instance;

class SignUpScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A2E43),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Image.asset(
                "assets/images/asilicon.png",
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            buildUserName(),
            SizedBox(
              height: 20,
            ),
            buildPassword(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xff273A5E),
                  border: Border.all(color: Color(0xff272B5E)),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ]),
              child: FlatButton(
                child: Text(
                  "KAYIT OL",
                  style: TextStyle(color: Colors.white54, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => adSoyadScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }



}

void _emailSifreSignUp() async {
  var firebaseUser = await _auth
      .createUserWithEmailAndPassword(
      email: HomePage.kullanici_adi, password: HomePage.sifre)
      .catchError((e) => debugPrint("Hata Alındı" + e.toString()));

  if (firebaseUser != null) {
    if (firebaseUser.user.isEmailVerified != true) {
      firebaseUser.user.sendEmailVerification().then((data) {
        debugPrint("Başarı ile Kaydınız yapıldı...\n lütfen girişinizi yapın");
        _auth.signOut();
      }).catchError((e) => debugPrint("Mail Gönderilirken Hata Alındı $e"));
    }

    debugPrint(
        "Uid: ${firebaseUser.user.uid} Mail: ${firebaseUser.user.email} MailOnayı: ${firebaseUser.user.isEmailVerified}");
  }
}

void _kullaniciKaydet(){
  Map<String,dynamic> kullaniciEkle=Map();
  kullaniciEkle['ad'] = HomePage.ad;
  kullaniciEkle['soyAd'] = HomePage.soyad;
  kullaniciEkle['e-mail'] = HomePage.kullanici_adi;


  _firestore.collection("Kullanıcılar").document("${HomePage.ad}_${HomePage.soyad}").setData(kullaniciEkle,merge: true).then((v) => debugPrint("Kullanıcı Başarılı bir şekilde kaydedildi..."));
}


class adSoyadScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff2A2E43),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Image.asset(
                "assets/images/asilicon.png",
                height: 150,
                width: 150,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            buildName(),
            SizedBox(
              height: 20,
            ),
            buildSurname(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xff273A5E),
                  border: Border.all(color: Color(0xff272B5E)),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ]),
              child: FlatButton(
                child: Text(
                  "Devam ET",
                  style: TextStyle(color: Colors.white54, fontSize: 20),
                ),
                onPressed: () {
                  _emailSifreSignUp();
                  _kullaniciKaydet();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}






Widget buildSurname() {
  return Container(
    width: double.infinity,
    height: 45,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
      color: Color(0xffA2A4AF),
      borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 5, left: 24, right: 16),
      child: TextField(
        onChanged: (veri) {
          HomePage.soyad = veri;
        },
        decoration: InputDecoration(
            hintText: "Soyad Giriniz",
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
            ),
            enabledBorder: InputBorder.none,
            suffixIcon: Icon(Icons.build)),
      ),
    ),
  );
}



Widget buildName() {
  return Container(
    width: double.infinity,
    height: 45,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
      color: Color(0xffA2A4AF),
      borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 5, left: 24, right: 16),
      child: TextField(
        onChanged: (veri) {
          HomePage.ad = veri;
        },
        decoration: InputDecoration(
            hintText: "Adınızı Giriniz",
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
            ),
            enabledBorder: InputBorder.none,
            suffixIcon: Icon(Icons.build)),
      ),
    ),
  );
}







Widget buildUserName() {
  return Container(
    width: double.infinity,
    height: 45,
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
      color: Color(0xffA2A4AF),
      borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 4),
        )
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(bottom: 5, left: 24, right: 16),
      child: TextField(
        onChanged: (veri) {
          HomePage.kullanici_adi = veri;
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
    margin: EdgeInsets.symmetric(horizontal: 50),
    decoration: BoxDecoration(
        color: Color(0xffA2A4AF),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ]),
    child: Padding(
      padding: EdgeInsets.only(bottom: 5, left: 24, right: 16),
      child: TextField(
        onChanged: (veri) {
          HomePage.sifre = veri;
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

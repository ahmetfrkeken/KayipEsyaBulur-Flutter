import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'homePage.dart';

class ForgetPassword extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            Text(
              "Lütfen Şifresini Unuttuğunuz Hesabınızın Mail Adresini Girin",
              style: TextStyle(fontFamily: "Ignite The Light", color: Color(0xffAFB1CC)),
            ),
            SizedBox(
              height: 50,
            ),
            buildUserName(),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 140,
              height: 40,
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
                  "ŞİFREMİ SIFIRLA",
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                onPressed: () {
                  _sifremiUnuttum();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sifremiUnuttum() {
    _auth
        .sendPasswordResetEmail(email: HomePage.kullanici_adi)
        .then((data) => debugPrint("Sıfırlama Mail i Gönderildi."))
        .catchError((e) => debugPrint("Hata Alındı. $e"));
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
}

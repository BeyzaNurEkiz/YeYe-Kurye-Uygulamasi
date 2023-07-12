import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF882A6),
                  Color(0xFFFFBED7),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
            ),
          ),
          title: const Text(
             "YeYe",
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: "Signatra",
                letterSpacing: 6
              ),
          ),
           centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Giriş Yap",
              ),
              Tab(
                icon: Icon(Icons.person, color: Colors.white,),
                text: "Kayıt ol",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 6,
          )
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFADFE6),
                Color(0xFFFADFE6),
              ],
            )
          ),
          child: const TabBarView(
            children: [
              LoginScreen(),
              RegisterScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

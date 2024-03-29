import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_zulmi/AdminPage.dart';
import 'package:flutter_login_zulmi/MemberPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

String username = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Zulmi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/AdminPage': (BuildContext context) =>
        new AdminPage(username: username,),
        '/MemberPage': (BuildContext context) =>
        new MemberPage(username: username,),
        '/MyHomePage': (BuildContext context) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response = await http.post(
        "http://10.0.2.2/flutter_login_zulmi/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['level'] == 'member') {
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
              Text("Username", style: TextStyle(fontSize: 18.0),),
            TextField(
              controller: user,
              decoration: InputDecoration(
                  hintText: 'Username'
              ),
            ),
            Text("Password", style: TextStyle(fontSize: 18.0),),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),

            RaisedButton(
              child: Text("Login"),
              onPressed: () {
                _login();
              },
            ),

            Text(msg, style: TextStyle(fontSize: 20.0, color: Colors.red),)
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

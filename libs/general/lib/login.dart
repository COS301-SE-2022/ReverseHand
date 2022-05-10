import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_comp/redux_comp.dart';
//import 'package:tradesman/tradesman.dart';
import 'package:consumer/consumer.dart';

void main() {
  //runApp(const Login());
}

class Login extends StatelessWidget {
  ///const Login({Key? key}) : super(key: key);
  final Store<AppState> store;
  const Login({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(store: store,),
    );
  }
}

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store, 
      child: MaterialApp(

      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 235, 235),
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                  ),
                ),
              ),
              const Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                ),
              ),
              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ConsumerListings(store: widget.store,)));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
   );
  }
}

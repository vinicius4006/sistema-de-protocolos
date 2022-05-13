import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protocolo_app/src/view/login/appEntrarLogin.dart';
import 'package:protocolo_app/src/view/login/appPassword.dart';
import 'package:protocolo_app/src/view/login/appUsername.dart';

class LoginProtocolo extends StatefulWidget {
  const LoginProtocolo({Key? key}) : super(key: key);

  @override
  State<LoginProtocolo> createState() => _LoginState();
}



class _LoginState extends State<LoginProtocolo> {

@override
void dispose() {
  debugPrint('Dispose Login');
  super.dispose();
}


  
  @override
  Widget build(BuildContext context) {
    debugPrint('Build Login');
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0x66ffa500),
                      Color(0x99ffa500),
                      Color(0xccffa500),
                      Color(0xffffa500),
                    ])),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  const <Widget>[
                      Text(
                        'Entrar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50,),
                      Username(),
                      SizedBox(height: 20,),
                      Password(),
                      SizedBox(height: 20,),
                      Entrar()
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 550,
                left: 140,
                width: 110,
                height: 200,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/logo.png'))
                  ),
                 
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}

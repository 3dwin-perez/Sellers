import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raidereats_sellers_app/authentication/auth_screen.dart';
import 'package:raidereats_sellers_app/global/global.dart';
import 'package:raidereats_sellers_app/mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}



class _MySplashScreenState extends State<MySplashScreen>
{

  startTime()
  {

    Timer(const Duration(seconds: 3),() async {
      if(firebaseAuth.currentUser != null)
        {
          // if seller is logged in already
          Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
        }
      else
        {
          // if seller is NOT logged in already
          Navigator.push(context, MaterialPageRoute(builder: (c) => AuthScreen()));
        }
    });
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/Chef.png"),

              const SizedBox(height: 10,),

              const Padding(
                padding:EdgeInsets.all(18.0),
                child: Text(
                  "Best Service to fulfill your expectations",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontFamily: "Bebas",
                    letterSpacing: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

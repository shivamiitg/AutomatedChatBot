import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Front extends StatefulWidget {
  const Front({Key? key}) : super(key: key);

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundImage:Image.asset('assets/cha')
      backgroundColor:Color.fromARGB(236, 228, 244, 248),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: AssetImage('assets/chatAi.jpg'),

                      height: 300,
                      width: 310,
                      color: Colors.white,

                      // ignore: prefer_const_constructors

                      colorBlendMode: BlendMode.darken,
                    ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            child: SizedBox(
              height: 50.0,
              child: Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(

            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            child: SizedBox(
              height: 35.0,
              child: Text(
                'Ask me anything ',
                style: TextStyle(

                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
              },
              child: Text(
                'Chat Now',
                style: TextStyle(
                  fontFamily: 'Dekko',
                  fontSize: 40.0,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 44, 141, 176),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 60.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

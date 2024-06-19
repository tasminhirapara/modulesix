import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modulesix/pageone.dart';
import 'package:modulesix/pagetwo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class dashbord extends StatefulWidget {
  const dashbord({super.key});

  @override
  State<dashbord> createState() => _dashbordState();
}

class _dashbordState extends State<dashbord> {
  SharedPreferences? logindata;
  late bool newuser;
  @override
  void check_if_already_login() async
  {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata?.getBool('login') ?? true);
    print(newuser);
    if (newuser == false)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homepage()));
    }
  }
  void initState() {
    super.initState();
    check_if_already_login();
  }
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150,),
            Icon(Icons.chat, color: Colors.indigoAccent, size: 90.0,),
            SizedBox(height: 20,),
            Text("Chatter", style: TextStyle(color: Colors.indigoAccent, fontSize: 20, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("WORLD'S MOST PRIVATE CHATTING APP", style: TextStyle(color: Colors.indigoAccent,),),

            SizedBox(height: 150,),
            SizedBox(height: 50, width: 220,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pageone()));
                }
                , child: Text("LOGIN", style: TextStyle(fontSize: 15,color: Colors.indigoAccent),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, //background color of button
                  side: BorderSide(width:3, color:Colors.indigoAccent), //border width and color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            SizedBox(height: 50, width: 220,
              child: ElevatedButton(
                onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>pagetwo()));}
                , child: Text("SIGNUP", style: TextStyle(fontSize: 15,color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 70,),
            Text("Made with ♥ By ChandaniDeveloper")

          ],
        ),
      ),
    );
  }
}

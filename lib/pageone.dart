import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modulesix/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pageone extends StatefulWidget {
  const pageone({super.key});

  @override
  State<pageone> createState() => _pageoneState();
}


class _pageoneState extends State<pageone> {
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SharedPreferences? logindata;
  late bool newuser;
  var isLoading = false;

  final cemail = TextEditingController();
  final cpassword = TextEditingController();



  void _login() async {
    final String emailt = cemail.text.trim();
    final String passwordt = cpassword.text.trim();
    try {
      // Retrieve user document by mobile number
      final QuerySnapshot result = await _firestore
          .collection('Chatter')
          .where('Email', isEqualTo: emailt)
          .limit(1)
          .get();

      if (result.docs.isEmpty) {
        // No user found with this email number
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No user found with this mobile number'),
        ));
        return;
      }

      final DocumentSnapshot userDoc = result.docs.first;

      // Check if the password matches
      if (userDoc['Password'] == passwordt) {
        // Successfully logged in
        // You can navigate to the next screen here
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: ListTile(leading: Icon(Icons.info_outline,color: Colors.white,size: 25,),
            title:Text("Login Succefull",style: TextStyle(color: Colors.white),) ,),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.indigoAccent,
        ));
        logindata?.setBool('login', false);//sharedprefrence name
        logindata?.setString('email', emailt);//username key
        logindata?.setString('pass', passwordt);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homepage()));
      } else {
        // Password mismatch
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: ListTile(leading: Icon(Icons.info_outline,color: Colors.white,size: 25,),
            title: Text("uh oh!",style: TextStyle(color: Colors.white,fontSize: 30),),
            subtitle:Text("Invalid Password",style: TextStyle(color: Colors.white),) ,),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.indigoAccent,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }


  @override

  void initState() {
    super.initState();
    check_if_already_login();
  }

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


  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 150,),
                Icon(Icons.chat, color: Colors.indigoAccent, size: 90.0,),
                SizedBox(height: 20,),
                Text("Chatter", style: TextStyle(color: Colors.indigoAccent, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(12.0),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: cemail,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.email, color: Colors.indigoAccent,),
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        final snackBar = SnackBar(
                          content: ListTile(leading: Icon(Icons.info_outline,color: Colors.white,size: 25,),
                            title: Text("uh oh!",style: TextStyle(color: Colors.white,fontSize: 30),),
                            subtitle:Text("Please enter email",style: TextStyle(color: Colors.white),) ,),
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.indigoAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return null;
                      }
                      return null;
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(12.0),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: cpassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.lock, color: Colors.indigoAccent,),
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        final snackBar = SnackBar(
                          content: ListTile(leading: Icon(Icons.info_outline,color: Colors.white,size: 25,),
                          title: Text("uh oh!",style: TextStyle(color: Colors.white,fontSize: 30),),
                          subtitle:Text("Please enter Password",style: TextStyle(color: Colors.white),) ,),
                          duration: Duration(seconds: 5),
                          backgroundColor: Colors.indigoAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return null;
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20,),

                SizedBox(
                  height: 50,
                  width: 220,
                  child: ElevatedButton(
                    onPressed: ()
                    {
                      if (_formkey.currentState!.validate())
                      {
                          _login();
                      }
                      else{


                      }
                    }, child: Text("Login", style: TextStyle(fontSize: 20,color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Text("or creat an account", style: TextStyle(fontSize: 15, color: Colors.indigoAccent),),
                SizedBox(height: 70,),
                Text("Made with ♥ By ChandaniDeveloper")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

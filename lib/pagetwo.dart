import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulesix/pageone.dart';

class pagetwo extends StatefulWidget {
  const pagetwo({super.key});

  @override
  State<pagetwo> createState() => _pagetwoState();
}

class _pagetwoState extends State<pagetwo> {
  final _formkey = GlobalKey<FormState>();

  String name = '';
  String mobileno = '';
  String email = '';
  String password = '';
  String confirmpassword = '';


  final nameController = TextEditingController();
  final mobilenoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  _clearText() {
    emailController.clear();
    passwordController.clear();
  }

  CollectionReference addUser =
  FirebaseFirestore.instance.collection('Chatter');
  Future<void> _registerUser() {
    return addUser
        .add({'Name':name,'Mobileno':mobileno,'Email': email, 'Password': password})
        .then((value) => Navigator.push(context,MaterialPageRoute(builder: (context) => pageone())))
        .catchError((_) => print('Something Error In registering User'));
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
                Icon(Icons.chat, color: Colors.indigoAccent, size: 70.0,),
                SizedBox(height: 20,),
                Text("Chatter", style: TextStyle(color: Colors.indigoAccent, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(12.0),
                  width: 300,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.person, color: Colors.indigoAccent,),
                      hintText: "Name",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'Please enter Name';
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
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: mobilenoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.phone, color: Colors.indigoAccent,),
                      hintText: "Mobile No",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'Please enter Mobile No';
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
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.email, color: Colors.indigoAccent,),
                      hintText: "Email",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (value) {
                      },
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'Please enter Email';
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
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.lock, color: Colors.indigoAccent,),
                      hintText: "Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'Please enter Password';
                      }
                      password=value;

                      return null;
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(7.0),
                  padding: EdgeInsets.all(12.0),

                  width: 300,
                  height: 48,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: confirmpasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.email, color: Colors.indigoAccent,),
                      hintText: "Confirm Password",
                      contentPadding: EdgeInsets.symmetric(vertical: 7),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty)
                      {
                        return 'Please enter Confirm Password';
                      }
                      if(value!=password)
                        {
                          return 'do not mantch Password';
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

                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          mobileno = mobilenoController.text;
                          email = emailController.text;
                          password = passwordController.text;
                          _registerUser();
                          _clearText();
                        });
                      }
                      }, child: Text("Sign Up", style: TextStyle(fontSize: 18,color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigoAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?", style: TextStyle(fontSize: 15, color: Colors.indigoAccent),),
                    TextButton(onPressed: ()
                      {Navigator.push(context, MaterialPageRoute(builder: (context) => pageone()));
                      },
                      child: Text("Login", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.indigoAccent),),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulesix/dashbord.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}
late bool _dataenabled=true;
late SharedPreferences logindata;
class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.indigoAccent),
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          toolbarOpacity: 1.0,
          flexibleSpace: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 20, width: 40),
                Text("Chatter", style: TextStyle(color: Colors.indigoAccent, fontSize: 20),),
                Expanded(child:
                Container(alignment: Alignment.center,
                         child: Text("by ChandaniDeveloper"),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout')
                {
                  logout();
                }
              },
              itemBuilder: (BuildContext context) {
                return ['logout'].map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
      ),drawer: Drawer(),
      body: Column(
        children: [
          RefreshIndicator(
            onRefresh: _pullRefresh,
            child:  FutureBuilder<List>
              (
              future: getdata(),
              builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (_dataenabled == false) {
                  Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  _dataenabled = true;
                  return Model(list: snapshot.data!!);
                }
                if (snapshot.hasError) {
                  _dataenabled = true;
                  print('Network Not Found');
                }
                _dataenabled = false;
                return Center(child: CircularProgressIndicator());
              } ),
          ),
      SizedBox(height: 200,),

      Row(
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 20, ),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 15,),

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: ()
              {

              }, icon: Icon(Icons.send, color: Colors.white, size: 20,),),
          ),
        ],
      ),
    ]
    )
    );
  }
  Future<List> getdata() async
  {
    var resp = await http.get(Uri.parse("https://tasmin123.000webhostapp.com/topsflutterproject/messageview.php"));
    return jsonDecode(resp.body);

  }
  Future<void> _pullRefresh()async
  {

   var resp = await http.get(Uri.parse("https://tasmin123.000webhostapp.com/topsflutterproject/messageview.php"));
   return jsonDecode(resp.body);

  }
  void logout() async
  {

    logindata = await SharedPreferences.getInstance();
    logindata.setBool('login', true); // Set the login flag back to true.
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => dashbord()));

  }
}

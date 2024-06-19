import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modulesix/dashbord.dart';
import 'package:modulesix/homepage.dart';
import 'package:modulesix/pageone.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget
{

  @override
  State<MyApp> createState() => _State();
}

class _State extends State<MyApp>
{
  final Future<FirebaseApp> _initailization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(

        future: _initailization,

        builder: (context, snapshot)
        {
          if(snapshot.hasError)
          {
            print('Something Went Wrong');
          }
          if(snapshot.connectionState == ConnectionState.done)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                appBarTheme: const AppBarTheme(
                  centerTitle: true,
                ),
              ),
              home:  dashbord(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
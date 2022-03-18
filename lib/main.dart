import 'dart:convert';

import 'package:curdapp/data.dart';
import 'package:curdapp/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

void main() {runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home:const FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  List allData = [];

  Future<dynamic> loadData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      allData = jsonDecode(sharedPreferences.getString('profileData')??'');
    });
    return allData;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton.small(onPressed: (){
      showModalBottomSheet(builder: (BuildContext context) {
        return const RegisterState();
      }, context: context);
    }),body: FutureBuilder<dynamic>(
      future:loadData() ,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(itemCount: allData.length,itemBuilder: (BuildContext context, int index) {

            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                const Home())

                );
              },
              child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Text(allData[index]['fName'],),
              ),
            );


          },);
        } return const Center(child: CircularProgressIndicator());
      }
    ),);
  }
}

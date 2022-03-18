import 'dart:convert';


import 'package:curdapp/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_stage.dart';

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

  styleG(double fs) => GoogleFonts.alata(fontSize: fs,fontWeight: FontWeight.w500);

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

            return Padding(
              padding: const EdgeInsets.only(top : 18.0,left: 15,right: 15),
              child: GestureDetector(
                onDoubleTap: (){

                },
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                   Home(index: index,))

                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(allData[index]['fName'],style: styleG(12),),
                          Text(allData[index]['lName'],style: styleG(12),),
                          Text(allData[index]['bd'],style: styleG(21),),
                        ],
                      ),
                      Text(allData[index]['phone'],style: styleG(21),),
                      Text(allData[index]['email'],style: styleG(21),),
                      Text(allData[index]['bankAcc'],style: styleG(21),),
                    ],
                  ),
                ),
              ),
            );


          },);
        } return const Center(child: CircularProgressIndicator());
      }
    ),);
  }
}

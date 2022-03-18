import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

    class Home extends StatefulWidget {
      const Home({Key? key}) : super(key: key);

      @override
      State<Home> createState() => _HomeState();
    }

    class _HomeState extends State<Home> {

    Future<dynamic>  loadData() async {

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

        return jsonDecode(sharedPreferences.getString('profileData')??'');



      }

       myContainer(Widget w) {
       return Padding(
         padding: const EdgeInsets.all(8.0),
         child: Container(child: Center(child: w),
           width: 300,height: 90,
           decoration: const BoxDecoration(color: Colors.white12,
             borderRadius: BorderRadius.all(Radius.circular(12))

           ),

         ),
       );
      }

      myStyle() {
      return GoogleFonts.alata(fontSize: 24,fontWeight: FontWeight.bold);
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(appBar: AppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder<dynamic>(
            future:loadData() ,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(children: [

                    myContainer(Text('First Name :${snapshot.data[0]['fName']}',style: myStyle(),)),
                    myContainer( Text('Last Name ${snapshot.data[0]['lName']}',style: myStyle())),
                    myContainer(Text('Date of BirthDay :${snapshot.data[0]['bd']}',style: myStyle())),
                    myContainer( Text('Phone Number : ${snapshot.data[0]['phone']}',style: myStyle())),
                    myContainer( Text('Email : ${snapshot.data[0]['email']}',style: myStyle())),
                    myContainer( Text('Bank Account : ${snapshot.data[0]['bankAcc']}',style: myStyle())),

                  ],),
                );

              }return const CircularProgressIndicator();
            }
          ),
        ),);
      }
    }

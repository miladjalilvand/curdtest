import 'dart:convert';


import 'data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterState extends StatefulWidget {
  const RegisterState({Key? key}) : super(key: key);

  @override
  State<RegisterState> createState() => _RegisterStateState();
}

class _RegisterStateState extends State<RegisterState> {



  bool checkData = false;



     TextEditingController firstName=TextEditingController();
     TextEditingController lastName=TextEditingController();
     TextEditingController  dateOfBirth = TextEditingController();
     TextEditingController phoneNumber = TextEditingController();
     TextEditingController email =TextEditingController();
     TextEditingController bankAccountNumber=TextEditingController();


  Widget customTextField(String title,var value,Icon ic,int l,bool numCheck) {
    return TextField(



      textAlign: TextAlign.start,
      controller: value,
      maxLength: l,
      minLines: 1,
      cursorWidth: 1,
      cursorColor: Colors.white,
      cursorRadius: const Radius.circular(3),
      style: GoogleFonts.adamina(fontSize: 15,color: Colors.white),
      maxLines: 1,
      keyboardType: numCheck ?   TextInputType.number
      :TextInputType.text,

      decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(

                color: Colors.white70
                , width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
                color: Colors.white, width: 3.0),),
          helperText: '',
          helperStyle: GoogleFonts.alata(fontSize: 12,color: Colors.white),
          label:  Text(title,style: GoogleFonts.aBeeZee(fontSize: 12,fontWeight: FontWeight.bold),),

          prefixIcon: ic,
          labelStyle: GoogleFonts.alata(fontWeight: FontWeight.w700,color: Colors.white),


          border: const OutlineInputBorder(borderSide: BorderSide(
              color: Colors.white,width: 1.0
          ),




          )


      ),

    );
  }

  List dataList =[];

  customFont(double fs ) {
    return GoogleFonts.alata(fontWeight: FontWeight.bold,fontSize: fs);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.only(top : 36.0,left: 12,right: 12),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [

            Row(
              children: [

                Expanded(
                    flex:6,
                    child: customTextField('title', firstName,const Icon(Icons.abc_outlined),30,false)
                ),
                const SizedBox(width: 3,),

                Expanded(
                    flex: 9,
                    child: customTextField('lastName',lastName,const Icon(Icons.abc_outlined),30,false)),
              ],
            ),

            customTextField('dateOfBirth',dateOfBirth,const Icon(Icons.calendar_today_outlined
              ,size: 24,),15,false),

            customTextField('PhoneNumber',phoneNumber,const Icon(Icons.add_call,size: 24,),15,true),

            customTextField('Email',email,const Icon(Icons.email,size: 24,),90,false),

            customTextField('BankAccountNumber',bankAccountNumber,const Icon(Icons.comment_bank,size: 24,),120,false),

            TextButton(onPressed: () async {


             SharedPreferences sh= await SharedPreferences.getInstance();
              Data data = Data(firstName.text, lastName.text, dateOfBirth.text, phoneNumber.text.toString(), email.text, bankAccountNumber.text);

              var tmpData = sh.getString('profileData');

              setState(() {
                if (tmpData != '') {
                   setState(() {
                     dataList = jsonDecode(tmpData??'');
                   });
                  debugPrint(dataList.toString());

                  debugPrint('check!');

                }
              });



              dataList.add(data);

              debugPrint(dataList.length.toString());

              //
              // while(i>=0){
              //
              //   if (i != 0) {
              //     if(dataList[i]['fName'] == firstName.text){
              //       debugPrint('name is Already');
              //       break;
              //
              //     }else if(dataList[i]['lName'] == lastName.text){
              //       debugPrint('family is Already');
              //       break;
              //     }else if(dataList[i]['email'] == dateOfBirth.text){
              //       debugPrint('email is Already');
              //       break;
              //     }
              //     else {
              //       i --;
              //     }
              //   }else {
              //


                var jsonData = jsonEncode(dataList);
                sh.setString('profileData', jsonData);
                Navigator.pop(context);  debugPrint('data saved');







            }, child: Text('SAVE',style:customFont(15),))


          ],

          ),
        )

      )

    );
  }
}

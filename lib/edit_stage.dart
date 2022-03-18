import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class Home extends StatefulWidget {
  final int index ;
  const Home({Key? key,required this.index}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  TextEditingController firstName=TextEditingController();
  TextEditingController lastName=TextEditingController();
  TextEditingController  dateOfBirth = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController bankAccountNumber=TextEditingController();

  String newVal = 'val';

  bool editor = false;

  List myData= [];

  Future<dynamic>  loadData() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      myData = jsonDecode(sharedPreferences.getString('profileData')??'');
    });

    return jsonDecode(sharedPreferences.getString('profileData')??'');



  }

  editContainer(String title,dynamic controller,String key,String tit){
    return  Padding(
      padding: const EdgeInsets.only(top:15.0,left: 15,right: 15),
      child: Column(
        children: [

          Text(tit,style: myStyle(),),
          TextField(


            controller: controller,
            textAlign: TextAlign.start,
            // controller: value,
            maxLength: 12,
            minLines: 1,
            cursorWidth: 1,

            cursorColor: Colors.white,
            cursorRadius: const Radius.circular(3),
            style: GoogleFonts.adamina(fontSize: 15,color: Colors.white),
            maxLines: 1,
            // keyboardType: numCheck ?   TextInputType.number
            //     :TextInputType.text,

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

                prefixIcon: null,
                labelStyle: GoogleFonts.alata(fontWeight: FontWeight.w700,color: Colors.white),


                border: const OutlineInputBorder(borderSide: BorderSide(
                    color: Colors.white,width: 1.0
                ),




                )


            ),

          ),
          IconButton(onPressed: (){
            setState(() {
              myData[widget.index][key]=controller.text;
            });
            // editProfile(jsonEncode(myData));
            updateDate(myData);
            Navigator.pop(context);
          }, icon: const Icon(Icons.done))
        ],
      ),

    );
  }

  myContainer(Widget w,String title,dynamic c,String key,String tit) {
    return GestureDetector(
      onTap: (){

        showModalBottomSheet(builder: (BuildContext context) {
          return Container(child: editContainer(title ,c,key,tit),);

        }, context: context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(child: Center(child: w),
          width: 300,height: 90,
          decoration: const BoxDecoration(color: Colors.white12,
              borderRadius: BorderRadius.all(Radius.circular(12))

          ),

        ),
      ),
    );
  }

  myStyle() {
    return GoogleFonts.alata(fontSize: 15,fontWeight: FontWeight.bold);
  }

  updateDate(dynamic newValue)async {


    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonData= jsonEncode(newValue);

    sharedPreferences.setString('profileData', jsonData);


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

                    myContainer(Text('First Name :${snapshot.data[widget.index]['fName']}',style: myStyle(),),snapshot.data[widget.index]['fName'],firstName,'fName','First Name'),
                    myContainer( Text('Last Name ${snapshot.data[widget.index]['lName']}',style: myStyle()),snapshot.data[widget.index]['lName'],lastName,'lName',
                        'LastName'),
                    myContainer(Text('Date of BirthDay :${snapshot.data[widget.index]['bd']}',style: myStyle()),snapshot.data[widget.index]['bd'],dateOfBirth,'bd',
                        'Date of Birthday'),
                    myContainer( Text('Phone Number : ${snapshot.data[widget.index]['phone']}',style: myStyle()),snapshot.data[widget.index]['phone'],phoneNumber,'phone','Phone Number'),
                    myContainer( Text('Email : ${snapshot.data[widget.index]['email']}',style: myStyle()),snapshot.data[widget.index]['email'],email,'email',
                        'Email'),
                    myContainer( Text('Bank Account : ${snapshot.data[widget.index]['bankAcc']}',style: myStyle()),snapshot.data[widget.index]['bankAcc'],bankAccountNumber,'bankAcc',
                        'Bank Acc '),

                    TextButton(onPressed: ()=> Navigator.pop(context), child: Text('back',style:myStyle(),))

                  ],),
                );

              }return const CircularProgressIndicator();
            }
        ),
      ),);
  }
}

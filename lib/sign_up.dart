
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';

import 'auth.dart';
import 'home.dart';
class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}
var isLoading;

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    SizedBox(
      height: 150,
    );
  setState(() {
    isLoading=false;
  });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ServePath'),
      ),
      body:Form(

      autovalidateMode: AutovalidateMode.always,
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          new Expanded(
            flex: 1,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("SignUp",style: TextStyle(color: Colors.blueAccent,fontSize: 32,fontWeight: FontWeight.w700),),
                ),
                Padding(padding: EdgeInsets.all(8),
                  child: TextFormField(
                    keyboardType: TextInputType.name,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]"))
                    ],
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25)
                      )
                    ),
                    onFieldSubmitted: (value){

                    },
                    validator: (value){
                      if(value==''){
                        return 'Please enter your name';
                      }
                    },

                  ),
                ),
                Padding(padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onFieldSubmitted: (value){},
                    validator: (value){
                      // ignore: unnecessary_null_comparison
                      if(isEmail(value!)==false){
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Padding(padding: EdgeInsets.all(8),
                  child:TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding:EdgeInsets.all(8),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(

                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onFieldSubmitted: (value){},
                    validator: (value){
                      if(value!.length!=10){
                        return 'Please enter valid Phone Number';
                      }
                    }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading=true;
                      });
                      bool authenticate=await register(context, _email.text, _password.text);

                      if (authenticate){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(uid: _email.text,),),);
                      }
                    },
                    child: Text(isLoading?'signing up...':'Submit'),

                  ),
                )

              ],
            )
          )
        ],
      ),
    ),
    );

  }
}
var occupationList=['Agriculture','student','Government Jobs','Lawyer','Doctor'];
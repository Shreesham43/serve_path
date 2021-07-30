import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:serve_path/auth.dart';
import 'package:serve_path/forgotPass.dart';
import 'package:serve_path/home.dart';
import 'package:serve_path/sign_up.dart';
import 'package:validators/validators.dart';
import 'color.dart';
class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Container(
        height: 40,
        width:5,
        child:
          Column(

            children:[CircularProgressIndicator(color: Colors.black,),]
          )
        ),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },

    );
  }



class _MyAppState extends State<MyApp> {

  var isLoadingSignIn=true;
  var isLoadingSignUp=true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController _sign_in_email = TextEditingController();
  TextEditingController _sign_in_password=TextEditingController();
  final _loginformkey = GlobalKey<FormState>();
  final _signupformkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    setState(() {
      isLoadingSignIn=false;
    });
    setState(() {
      isLoadingSignUp=false;
    });

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(

          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Color.fromRGBO(16, 5, 61, 1.0),
            automaticallyImplyLeading: false,
            title: Text('ServePath'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Already Have an \nAccount? Login',),
                Tab(text: 'New to ServePath?\nsignUp',),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _loginformkey,
                child: SingleChildScrollView(
                  child: Column(
                    children:<Widget> [
                      new Expanded(
                        flex: 0,
                        child:Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text("Login",style: TextStyle(color:Color.fromRGBO(16, 5, 61, 1.0) ,fontSize: 32,fontWeight: FontWeight.w700),),
                            ),
                            Padding(padding: EdgeInsets.all(8),
                            child: TextFormField(
                              controller: _sign_in_email,
                              decoration: InputDecoration(
                                labelText: 'Usename',
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
                                controller: _sign_in_password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onFieldSubmitted: (value){},
                                validator: (value){
                                  if(value==''){
                                    return 'Enter the password';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary:Color.fromRGBO(16, 5, 61, 1.0) ),
                                onPressed: () async {
                                  showLoaderDialog(context);
                                  setState(() {
                                    isLoadingSignIn=true;
                                  });
                                  bool authenticate=await signIn(context,_sign_in_email.text, _sign_in_password.text);
                                  if (authenticate){

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(uid: _sign_in_email.text,),),);

                                  }
                                },
                                child: Text(isLoadingSignIn?'Signing in...':'Submit'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Forgot Password?',
                                  style:TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                                  recognizer: TapGestureRecognizer()
                                  ..onTap=(){
                                    Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>ForgotPass()));
                                  }
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: isLoadingSignIn?CircularProgressIndicator():Container(),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: _signupformkey,
                child:SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:<Widget> [
                      new Expanded(
                        flex: 0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text("SignUp",style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 32,fontWeight: FontWeight.w700),),
                            ),
                            Padding(padding: EdgeInsets.all(8),
                              child: TextFormField(
                                controller: _name,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(25)
                                  )
                                ),
                                //onFieldSubmitted: (value){},
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
                                controller: _phone,
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
                                style: ElevatedButton.styleFrom(primary: Color.fromRGBO(16, 5, 61, 1.0)),
                                onPressed: () async {
                                  showLoaderDialog(context);
                                  setState(() {
                                    isLoadingSignUp=true;
                                  });
                                  bool adduser=false;
                                  bool authenticate=await register(context, _email.text, _password.text);
                                  if(authenticate){adduser=addUser(_name.text,_email.text,_phone.text) ;}
                                  if (adduser){
                                    setState(() {
                                      isLoadingSignUp=false;
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(uid: _email.text,),),);
                                  }
                                },
                                child: Text(isLoadingSignUp?'signing up...':'Submit'),
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        )
      )
    );
  }
}

  bool addUser(String name,String username, String phone){
    FirebaseFirestore.instance.runTransaction((transaction) async {
      try{
        CollectionReference users=FirebaseFirestore.instance.collection('Users');
        await users.add({
          'Name':name,
          'Username':username,
          'Phone':phone,
          'FavoriteDep':[],
          'FavoriteServ':[],

        });
        return true;
      }
      catch(e){
        throw(e);

      }

    });
  return true;
  }

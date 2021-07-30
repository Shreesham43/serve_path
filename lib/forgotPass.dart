import 'package:flutter/material.dart';
import 'package:serve_path/auth.dart';
import 'package:serve_path/home.dart';
import 'package:serve_path/login_form.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({ Key? key }) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizedBox(

      height: 150,
    );return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16, 5, 61, 1.0),
        accentColor: Color.fromRGBO(16, 5, 61, 1.0),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('ServePath'),
          brightness: Brightness.dark,
        ),

        backgroundColor: Colors.white,
        body: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Forgot Password",style:TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 32,fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText:'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey)
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color.fromRGBO(16, 5, 61, 1.0)),
                  onPressed: () async {
                    bool authenticate=await forgotPassword(context, _email.text) ;
                    if(authenticate){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                    }
                  }, child: Text('Submit')
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
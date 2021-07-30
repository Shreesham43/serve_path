import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:serve_path/home.dart';
import 'package:serve_path/update.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:serve_path/Display.dart';
import 'login_form.dart';

class Profile extends StatelessWidget {
  const Profile({ Key? key,required  this.uid }) : super(key: key);
  final uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Users').where('Username',isEqualTo: uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData)
          return CircularProgressIndicator(color: Color.fromRGBO(16, 5, 61, 1.0),);
        return Container(
          width: 260,
          color: Colors.white,
          child: uid!="Guest"?Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Row(

                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child:Icon(Icons.account_circle_rounded,size:40,color: Color.fromRGBO(16, 5, 61, 1.0),),
                  ),
                  Text("Hello, "+snapshot.data.documents[0].get('Name')),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 12, 12, 12),
                    child: IconButton(
                      icon:Icon(Icons.edit,color: Colors.black,),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Update(email:snapshot.data.documents[0].get('Username'), name:snapshot.data.documents[0].get('Name'),phone:snapshot.data.documents[0].get('Phone'))));
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 5,
                    color: Colors.black,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 10, 0, 0),
                    child: Text("Email"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 10, 0, 0),
                    child:Text(snapshot.data.documents[0].get('Username')),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: Text("Contact Number",textAlign: TextAlign.start,),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 10, 0, 0),
                    child:Text(snapshot.data.documents[0].get('Phone'),textAlign: TextAlign.start,),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Favorites',
                        style:TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                        recognizer: TapGestureRecognizer()
                        ..onTap=(){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>DisplayFav(uid:uid)));
                        }
                      ),
                    )

                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Logout',
                        style:TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                        recognizer: TapGestureRecognizer()
                        ..onTap=(){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>Home(uid: "Guest")));
                        }
                      ),
                    )
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: Text("Mail us your Queries"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: IconButton(
                      icon:Icon(Icons.mail),
                      onPressed: _sendMails,
                    ),

                  )
                ],
              ),
            ],
          )
          :Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child:Icon(Icons.account_circle_rounded,size:40,color: Color.fromRGBO(16, 5, 61, 1.0),),
                  ),
                  Text("Hello, "+snapshot.data.documents[0].get('Name')),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 0.1,
                    color: Colors.black,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(14, 30, 200, 0),
                child: RichText(
                  text: TextSpan(
                    text: 'Sign In',

                    style:TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                    recognizer: TapGestureRecognizer()
                    ..onTap=(){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>MyApp()));
                    }
                  ),
                )
              ),
              Row(
                children: [
                  Padding(
                    padding:EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: Text("Mail us your Queries"),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 30, 0, 0),
                    child: IconButton(
                      icon:Icon(Icons.mail),
                      onPressed: _sendMails,
                    ),

                  )
                ],
              ),
            ],
          )
        );
      },
    );
  }
}


_sendMails(){
  launch("mailto:admin@servepath.com");
}
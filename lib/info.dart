import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Info extends StatelessWidget {
  final id,index;
  final int lineno=0;
  const Info({ Key? key ,required this.id,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(index);
    return Scaffold(
      appBar:AppBar(

        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),

      ),
      body: ListView(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Schemes').orderBy('Likes').snapshots(),
            builder: (context,AsyncSnapshot snapshot){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 100, 10),
                    child: RichText(
                      text: TextSpan(
                        text: ('Steps to obtain '+id),
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 24)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: RichText(

                      text: TextSpan(
                        text: ("\u2022 "+snapshot.data.documents[index].get('Data')).replaceAll('\\n', '\n'+'\u2022 '),

                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 16),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 10, 115, 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Documents Required',
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 24)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: ('\u2022 '+snapshot.data.documents[index].get('Documents')).replaceAll('\\n', '\n'+'\u2022 '),
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 16)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 10, 260, 10),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'Website',
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 24)
                      ),
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                                  ..onTap=(){ launch(snapshot.data.documents[index].get('Link')); },
                      text: snapshot.data.documents[index].get('Link'),
                      style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontSize: 16)
                    )
                  )

                ],
              );
            },
          )
        ],
      ),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final uid;
  const ChatScreen({ Key? key, required this.uid }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  var _allResults;

  getMessages() async{
    var list=await FirebaseFirestore.instance.collection('Messages').where(FieldPath.documentId,isEqualTo: widget.uid).orderBy('Time').snapshots();
    setState(() {
      //_allResults=list.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),
      ),
      body: Expanded(
        child: Column(
          children: [
            StreamBuilder(
              stream:FirebaseFirestore.instance.collection('Messages').snapshots(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                return Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder:snapshot.data.documents.map((DocumentSnapshot document){
                      bool isme=document['IsMe'];
                      isme?Container(

                        width: 150,
                        padding: EdgeInsets.fromLTRB(10, 10, 150, 10),
                        child:Column(

                          children: [
                            Text(document['Message'])
                          ],
                        )
                      )
                      :Container(
                        width: 150,
                        padding: EdgeInsets.fromLTRB(10, 10, 150, 10),
                        child:Column(
                          children: [
                            Text(document['Message'])
                          ],
                        )
                      );

                    }),
                  ),
                );
              },
            ),
            Row(
              children: [
                SizedBox(
                  width:270,
                  child:TextField(
                    decoration:InputDecoration(
                      hintText: 'Enter Message',
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )
                    )
                  )
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed:(){},
                )
              ],
            )
          ],
        ),
      ),


    );
  }
}

Widget message(){
  return Container(
    decoration: BoxDecoration(
      color: Color.fromRGBO(16, 5, 61, 1.0),
    ),
  );
}
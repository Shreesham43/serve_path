import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:serve_path/profile.dart';
import 'package:serve_path/search.dart';
import 'AllDep.dart';
import 'AllSchemes.dart';
import 'DepDetail.dart';
import 'info.dart';

class Home extends StatefulWidget {
  const Home({ Key? key, required this.uid }) : super(key: key);
  final String uid;
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>  {
  var fav;

  late bool favorite=false;
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:Text('No'),
            ),

            ElevatedButton(
              onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              //return true when click on "Yes"
              child:Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }

    debugPrint(widget.uid);
    return  WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(

        endDrawer: Profile(uid: widget.uid ,),
          resizeToAvoidBottomInset: false,
          appBar:AppBar(

            brightness: Brightness.dark,
            automaticallyImplyLeading: false,
            title: Text('ServePath'),
            actions: <Widget>[
              IconButton(
                onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(uid: widget.uid,)));
                },
                icon: Icon(Icons.search),
              ),

            ]
          ),
          body: ListView(
             children:[
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(children: [Text('Departments', style: TextStyle(fontSize: 18),)],),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Departments').orderBy('DepLikes').limit(6).snapshots(),
                    builder: (context, AsyncSnapshot snapshot ){
                      return !snapshot.hasData?
                        Center(
                          child:CircularProgressIndicator(),
                        )
                      :Container(
                        child: GridView.builder(
                          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                          primary: true,

                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 3),

                            itemBuilder: (context,index){


                              return GestureDetector(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DepDetail(id:snapshot.data.documents[index].id,uid: widget.uid,)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [BoxShadow(
                                      color: Colors.white,

                                    )]
                                  ),
                                  margin: EdgeInsets.only(bottom: 10,left: 8,right: 8),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(3)),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                   Padding(
                                                     padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                     child: Image.network(snapshot.data.documents[index].get('Icon'),width:49,height:80),
                                                   )
                                                ],
                                              ),
                                              if(widget.uid!="Guest")
                                                Column(
                                                  children:[
                                                    IconButton(
                                                      iconSize: 18,
                                                      padding: const EdgeInsets.all(1),
                                                      onPressed: (){
                                                        addfavoritesDep(widget.uid, snapshot, index);
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to favorites"),));
                                                      },
                                                      icon: Icon( Icons.favorite_border,color: Color.fromRGBO(16, 5, 61, 1.0),
                                                      ),
                                                    )
                                                  ]
                                                ),

                                            ],
                                          )
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(snapshot.data.documents[index].id,overflow: TextOverflow.fade,),
                                      ),

                                    ],
                                  )
                                ),
                              );
                            },
                          ),
                        );

                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(220, 5, 5, 5),
                    child: RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                                    ..onTap=(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AllDep(uid: widget.uid,)));},
                        text: 'More Items...',
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(children: [Text('Services', style: TextStyle(fontSize: 18),)],),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('Schemes').orderBy('Likes').limit(6).snapshots(),
                    builder: (context, AsyncSnapshot snapshot ){
                      return !snapshot.hasData?
                        Center(
                          child:CircularProgressIndicator(),
                        )
                      :Container(
                        child: GridView.builder(
                          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                          primary: true,

                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            crossAxisCount: 3),

                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(id:
                                   snapshot.data.documents[index].id,index:index),

                                     ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    boxShadow: [BoxShadow(
                                      color: Colors.white,

                                    )]
                                  ),
                                  margin: EdgeInsets.only(bottom: 10,left: 8,right: 8),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(3)),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                   Padding(
                                                     padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                     child: Image.network(snapshot.data.documents[index].get('Icon'),width:49,height:80),
                                                   )
                                                ],
                                              ),
                                              if(widget.uid!="Guest")
                                                Column(
                                                  children:[
                                                    IconButton(
                                                      iconSize: 18,
                                                      padding: const EdgeInsets.all(1),
                                                      onPressed: (){
                                                        addfavoritesServ(widget.uid, snapshot, index);
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to favorites"),));
                                                      },
                                                      icon: Icon( Icons.favorite_border,color: Color.fromRGBO(16, 5, 61, 1.0),
                                                      ),
                                                    )
                                                  ]
                                                ),

                                            ],
                                          )
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(snapshot.data.documents[index].id,overflow: TextOverflow.fade,),
                                      ),

                                    ],
                                  )
                                ),
                              );
                            },
                          ),
                        );

                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(220, 5, 5, 5),
                    child: RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                                    ..onTap=(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AllSchemes(uid: widget.uid,)));},
                        text: 'More Items...',
                        style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0)),
                      ),
                    ),
                  ),
                ],
                     ),
             ],
          ),
        ),
    );

  }
}

//Future<bool> removefavorites(String uid,AsyncSnapshot snapshot,int index) async {
//  try {
 //   var collection=await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
//    var array=collection.docs[0].get('FavoriteDep');
//    array.remove(snapshot.data.documents[index].id);
//    CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
//    QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: uid).get();
 //   querySnapshot.docs[0].reference.update({"FavoriteDep":array});
//    return true;
//  } catch (e) {
//    return false;
//  }
//}

Future<bool> addfavoritesDep(String uid,AsyncSnapshot snapshot,int index) async {
  try{

  var collection1= await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
  Set array1= collection1.docs[0].get('FavoriteDep').toSet();
  array1.add(snapshot.data.documents[index].id);
  List l1= array1.toList();
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: uid).get();
  querySnapshot.docs[0].reference.update({"FavoriteDep":l1});
  return true;
  }catch(e){
    debugPrint(e.toString());
    return false;
  }
}
Future<bool> addfavoritesServ(String uid,AsyncSnapshot snapshot,int index) async {
  try{

  var collection2= await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
  Set array2= collection2.docs[0].get('FavoriteServ').toSet();
  array2.add(snapshot.data.documents[index].id);
  List l2 = array2.toList();
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: uid).get();
  querySnapshot.docs[0].reference.update({"FavoriteServ":l2});
  return true;
  }catch(e){
    debugPrint(e.toString());
    return false;
  }
}

Future<bool> isFavorite(String uid,AsyncSnapshot snapshot,int index)async {
  try{
    var collection= await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
    if(collection.docs[0].get('FavoriteDep').contains(snapshot.data.documents[index].id)){
      debugPrint("true");
    return true;
    }else
    return false;
  }catch (e){
    return false;
  }
}

// ignore: non_constant_identifier_names
Future<bool> Compare() async{
  await FirebaseFirestore.instance.collection("Users").get();
  debugPrint("Compared");
  return true;
}


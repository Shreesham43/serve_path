
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'DepDetail.dart';
import 'info.dart';

class DisplayFav extends StatefulWidget {
  const DisplayFav({ Key? key, required this.uid }) : super(key: key);
  final String uid;

  @override
  _DisplayFavState createState() => _DisplayFavState();
}

class _DisplayFavState extends State<DisplayFav> {
  late QuerySnapshot collection1;
  int j=0,i=0;
  int w=0,z=0;
  Map map1=new Map();
  Map map2=new Map();
  //late int length;
  getDep()async{
    collection1=await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: widget.uid).get();
    return collection1;

     //for(String i in array1)
      //debugPrint(i);
    //debugPrint("hello");


  }

   initState()  {
    super.initState();
    getDep();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),
      ),
      body:ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Departments").snapshots() ,
            builder: (context,AsyncSnapshot snapshot){
              if(collection1.docs[0].data()['FavoriteDep'].length!=0){
                Text('Departments', style: TextStyle(fontSize: 18),);
              }
              return ListView.builder(
                shrinkWrap: true,

                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount:(collection1.docs[0].data()['FavoriteDep'].length),
                itemBuilder: (BuildContext context, index){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  for(;i<snapshot.data.documents.length;){
                    //print("hello");
                    j=i;
                    i=i+1;
                    print(i);
                    debugPrint(snapshot.data.documents[j].id);
                    if(collection1.docs[0].data()['FavoriteDep'].contains(snapshot.data.documents[j].id)){
                      debugPrint(snapshot.data.documents[j].id);
                      map1[index]=j;
                      return buildcardDep(context,snapshot, snapshot.data.documents[j],widget.uid,index,map1);
                    }

                  }
                  return Container();
                },
              );
            },
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Schemes").snapshots() ,
            builder: (context,AsyncSnapshot snapshot){
              if(collection1.docs[0].data()['FavoriteServ'].length!=0){
                Text('Services', style: TextStyle(fontSize: 18),);
              }
              return ListView.builder(
                physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount:(collection1.docs[0].data()['FavoriteServ'].length),
                itemBuilder: (BuildContext context, index){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  for(;z<snapshot.data.documents.length;){
                    //print("hello");
                    w=z;
                    z=z+1;
                    print(z);
                    debugPrint(snapshot.data.documents[w].id);
                    if(collection1.docs[0].data()['FavoriteServ'].contains(snapshot.data.documents[w].id)){
                      debugPrint(snapshot.data.documents[w].id);
                      map2[index]=w;
                      return buildcardServ(context,snapshot, snapshot.data.documents[w],widget.uid,index,map2);
                    }

                  }
                  return Container();
                },
              );
            },
          )
        ],

      ),
    );
  }
}
Widget buildcardDep(BuildContext context,snapshot ,_result,uid,index,map){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DepDetail(id:
        _result.id, uid: uid,),

      ));
    },
      child: Container(
                height: 130,
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
                                    child: Row(
                                      children: [
                                        Image.network(_result.get('Icon'),width:49,height:80),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20,left: 210),
                                          child:IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: (){
                                              removefavoritesDep(uid,snapshot, index,map);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from favorites"),));
                                            },
                                          )
                                        )
                                      ],
                                    )
                                  ),

                                ],
                              ),

                            ],
                          )
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(14, 10, 0, 15),
                            child: Text(_result.id,textAlign: TextAlign.start,),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
    );
}
Widget buildcardServ(BuildContext context,snapshot ,_result,uid,index,map){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Info(id:
        _result.id,index:index),

      ));
      },
      child: Container(
                height: 130,
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
                                    child: Row(
                                      children: [
                                        Image.network(_result.get('Icon'),width:49,height:80),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20,left: 210),
                                          child:IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: (){
                                              removefavoritesServ(uid,snapshot, index,map);
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed from favorites"),));
                                            },
                                          )
                                        )
                                      ],
                                    )
                                  ),

                                ],
                              ),

                            ],
                          )
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(14, 10, 0, 15),
                            child: Text(_result.id,textAlign: TextAlign.start,),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
    );
}
Future<bool> removefavoritesDep(String uid, snapshot,int index,Map map) async {
  try{
    int val=map[index];
    print("removing1");
  var collection= await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
  List array= collection.docs[0].get('FavoriteDep');
  print(array.remove(snapshot.data.documents[val].id));
  //List l1= array.toList();

  print("removing");
  for(String i in array)print(i);
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: uid).get();
  querySnapshot.docs[0].reference.update({"FavoriteDep":array});
  print("removed");
  return true;
  }catch(e){
    debugPrint(e.toString());
    return false;
  }
}
Future<bool> removefavoritesServ(String uid, snapshot,int index,Map map) async {
  try{
    int val=map[index];
    print("removing1");
  var collection= await FirebaseFirestore.instance.collection("Users").where("Username",isEqualTo: uid).get();
  List array= collection.docs[0].get('FavoriteServ');
  print(array.remove(snapshot.data.documents[val].id));
  //List l1= array.toList();

  print("removing");
  for(String i in array)print(i);
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: uid).get();
  querySnapshot.docs[0].reference.update({"FavoriteServ":array});
  print("removed");
  return true;
  }catch(e){
    debugPrint(e.toString());
    return false;
  }
}

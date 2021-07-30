import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serve_path/search.dart';

import 'DepDetail.dart';

class AllDep extends StatelessWidget {
  const AllDep({ Key? key, required this.uid }) : super(key: key);
  final uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar:AppBar(

        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(uid: uid,)));
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
                stream: FirebaseFirestore.instance.collection('Departments').orderBy('DepLikes').snapshots(),
                builder: (context, AsyncSnapshot snapshot ){
                  return !snapshot.hasData?
                    Center(
                      child:CircularProgressIndicator(),
                    )
                  :Container(
                    child: GridView.builder(

                      primary: true,

                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisCount: 3),

                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>DepDetail(uid: uid, id: snapshot.data.documents[index].id,)));
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
                                          if(uid!="Guest")
                                          Column(
                                            children: [
                                              IconButton(
                                                iconSize: 18,
                                                padding: const EdgeInsets.all(1),
                                                onPressed: (){
                                                  addfavoritesDep(uid, snapshot, index);
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to favorites"),));
                                                },
                                                icon:Icon(Icons.favorite_border,color: Color.fromRGBO(16, 5, 61, 1.0),),
                                              )
                                            ],
                                          )

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
            ],
          ),
        ],
      ),
    );
  }
}
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



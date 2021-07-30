import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serve_path/DepDetail.dart';
import 'package:serve_path/scheme.dart';
import 'package:serve_path/searchService.dart';

import 'info.dart';

class Search extends StatefulWidget {
  const Search({ Key? key ,required this.uid}) : super(key: key);
  final uid;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController=TextEditingController();
  late Future resultsLoaded1;
  late Future resultsLoaded2;
  List _allResults1=[];
  List _resultsList1=[];
  var showResults1=[];
  List _allResults2=[];
  List _resultsList2=[];
  var showResults2=[];
  @override

  void didChangeDependencies(){
    super.didChangeDependencies();
    resultsLoaded1=getSchemes();
  }
  void initState(){
    super.initState();
    _searchController.addListener(_onSearchChanged);
    //super.dispose();
  }
  _onSearchChanged(){
    searchResultsList();
  }
  searchResultsList(){

    // ignore: unused_local_variable
    String name;

    if(_searchController.text==''){

       _resultsList1=[];
       _resultsList2=[];
    }
    else{
      for(var i in _allResults1){

        name=i['Name'].toLowerCase();
        if(name.contains(_searchController.text.toLowerCase())){
          showResults1.add(i);
        }
      }
      for(var i in _allResults2){

        name=i['Name'].toLowerCase();
        if(name.contains(_searchController.text.toLowerCase())){
          showResults2.add(i);
        }
      }
    }
    setState(() {
      _resultsList1=showResults1;
      showResults1=[];
      _resultsList2=showResults2;
      showResults2=[];
    });
  }
  getSchemes() async{
    var schemes=await FirebaseFirestore.instance.collection('Schemes').get();
    var deps=await FirebaseFirestore.instance.collection('Departments').get();
    setState(() {
      _allResults1=schemes.docs;
      _allResults2=deps.docs;
    });
    searchResultsList();
    return 'complete';
  }
  ScrollController controller=new ScrollController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(

        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),
      ),
      body: ListView(
        controller: controller,
        physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()) ,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(

              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left:25),
                hintText: 'Search Departments and Services',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),

                ),

              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if(_resultsList1.length!=0)Text('Services', style: TextStyle(fontSize: 18),),
          ListView.builder(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount:_resultsList1.length,
            itemBuilder:(BuildContext context,int index)=>buildcardServ(context,_resultsList1[index], index,widget.uid)

          ),
          if(_resultsList2.length!=0)Text('Departments', style: TextStyle(fontSize: 18),),
          ListView.builder(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount:_resultsList2.length,
            itemBuilder:(BuildContext context,int index)=>buildcardDep(context,_resultsList2[index], index,widget.uid)
          )
        ],
      ),
    );
  }
}

Widget buildcardDep(BuildContext context, _result,index,uid){
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
                          child: Image.network(_result.get('Icon'),width:49,height:80),
                        )
                      ],
                    ),
                  ],
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(_result.id,overflow: TextOverflow.fade,),
            ),
          ],
        )
      ),
    );
}
Widget buildcardServ(BuildContext context, _result,index,uid){
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
                          child: Image.network(_result.get('Icon'),width:49,height:80),
                        )
                      ],
                    ),
                  ],
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(_result.id,overflow: TextOverflow.fade,),
            ),
          ],
        )
      ),
    );
}


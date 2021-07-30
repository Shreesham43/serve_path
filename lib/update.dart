import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Update extends StatelessWidget {
  Update({ Key? key, this.name,this.phone, this.email}) : super(key: key);
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

  final email;
  final name;
  final phone;
  @override
  Widget build(BuildContext context) {
  final TextEditingController _updateName=TextEditingController(text:name);
  final TextEditingController _updatePhone=TextEditingController(text:phone);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        title: Text('ServePath'),
      ),
      body: Container(
        child:Column(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            child: Text("Update Details",style: TextStyle(color:Color.fromRGBO(16, 5, 61, 1.0) ,fontSize: 32,fontWeight: FontWeight.w700),),
                          ),
                          Padding(padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _updateName,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            )
                          ),
                          Padding(padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _updatePhone,
                              decoration: InputDecoration(
                                labelText: 'Contact Number',
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary:Color.fromRGBO(16, 5, 61, 1.0) ),
                              onPressed: () async {
                                showLoaderDialog(context);

                                bool authenticate=await update(email,_updateName.text, _updatePhone.text);
                                if (authenticate){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(uid: email,),),);
                                  }
                                },
                                child: Text('Update'),
                              ),
                            ),
                        ]
                      ),
                    ),
                  ]
                )
              )
            )
          ]
        )
      ),
    );
  }
}
update(String email,String name, String phone) async{
  CollectionReference collectionReference=FirebaseFirestore.instance.collection('Users');
  QuerySnapshot querySnapshot=await collectionReference.where("Username",isEqualTo: email).get();
  querySnapshot.docs[0].reference.update({"Name":name,"Phone":phone});
  return true;
}
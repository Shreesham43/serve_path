import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<bool> register(BuildContext context, String email,String password) async {
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e){
    if(e.code=='email-already-in-use'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('This email id is already in use',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    else if(e.code=='invalid-email'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please enter valid email id',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    else if(e.code=='operation-not-allowed'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Email is not enabled',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    else if(e.code=='weak-password'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please create Strong Password',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    return false;
  }catch (e){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(e.toString(),style: TextStyle( color: Colors.blueAccent,fontWeight: FontWeight.w500),),
        );
      }
    );
    return false;
  }
}

Future<bool> signIn(BuildContext context,String email,String password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  }on FirebaseAuthException catch (e){
    debugPrint(e.code);
    if(e.code=='invalid-email'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please enter valid email ID',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    else if(e.code=='user-disabled'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('The user has been disabled',style: TextStyle( color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='user-not-found'){
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Username not found',style: TextStyle( color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    else if(e.code=='wrong-password'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please enter correct password',style: TextStyle( color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    return false;
  }catch (e){
    showDialog(
      context: context,
      builder: (context){
          return AlertDialog(
            title: Text(e.toString(),style: TextStyle( color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
        );
      }
    );
    return false;
  }
}

Future<bool> forgotPassword(BuildContext context,String email) async {
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return true;
  }on FirebaseAuthException catch(e){
    if(e.code=='auth/invalid-email'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please enter valid email ID',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/missing-continue-uri'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Continue URL isn\'t provided',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/missing-ios-bundle-id'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Please provide an iOS Bundle ID if an App Store ID is provided.',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/invalid-continue-uri'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('The URL provided in the request isn\'t valid. ',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/unauthorized-continue-uri'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('The domain isn\'t authorised. Please contact the admin ',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/user-not-found'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('User not found',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    if(e.code=='auth/missing-android-pkg-name'){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Android package name isn\'t specified',style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
          );
        }
      );
    }
    return false;
  }catch (e){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(e.toString(),style: TextStyle(color: Color.fromRGBO(16, 5, 61, 1.0),fontWeight: FontWeight.w500),),
        );
      }
    );
    return false;
  }
}

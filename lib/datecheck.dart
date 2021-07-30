import 'package:intl/intl.dart';
void main(){
  var date=DateTime.now();
  String formatteddate=DateFormat('dd\MM\yyyy\n kk:mm:ss').toString();
  print(formatteddate);
}
import 'package:cloud_firestore/cloud_firestore.dart';

class FireModel{
  String? motto;
  Timestamp? date;
  DocumentReference? reference;

  FireModel({this.motto, this.date, this.reference});
  FireModel.fromJson(dynamic json, this.reference){
    motto = json['motto'];
    date = json['date'];
  }

  FireModel.fromSnapShot(DocumentSnapshot <Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  FireModel.fromQuerySnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data(), snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['motto'] = motto;
    map['date'] = date;
    return map;
  }
}
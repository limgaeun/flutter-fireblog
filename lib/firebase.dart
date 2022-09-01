import 'package:cloud_firestore/cloud_firestore.dart';
import 'firemodel.dart';

class FireService{
  static final FireService _fireService = FireService._internal();
  factory FireService() => _fireService;
  FireService._internal();
  //Create
  Future createMemo(Map<String, dynamic> json) async{
    await FirebaseFirestore.instance.collection('memo').add(json);
  }
  //Read
  Future<List<FireModel>> getFireModel() async{
    CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection('memo');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.orderBy('date').get();

    List<FireModel> mottos =[];
    for (var doc in querySnapshot.docs){
      FireModel fireModel = FireModel.fromQuerySnapShot(doc);
      mottos.add(fireModel);
    }
    return mottos;
  }
  //Update
  Future updateMemo({required DocumentReference reference, required Map<String, dynamic> json}) async{
    await reference.set(json);
  }
  //Delete
  Future<void> deleteMemo(DocumentReference reference) async {
    await reference.delete();
  }
}
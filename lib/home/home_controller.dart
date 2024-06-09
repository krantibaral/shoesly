import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

//SHOES DETAILS FROM SHOES COLLECTIO
  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getDataStream() {
    return firestore.collection('Shoes').snapshots().map(
          (querySnapshot) => querySnapshot.docs.toList(),
        );
  }

//LIST FOR THE TYPES OF SHOES
  Future<List<String>> getTypes() async {
    var querySnapshot = await firestore.collection('Shoes').get();
    var types = querySnapshot.docs
        .map((doc) => doc.data()['type'] as String)
        .toSet()
        .toList();
    return types;
  }
}

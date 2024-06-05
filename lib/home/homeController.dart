import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<List<DocumentSnapshot<Map<String, dynamic>>>> getDataStream() {
  return firestore.collection('Shoes').snapshots().map(
    (querySnapshot) => querySnapshot.docs.toList(),
  );
}


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pine_app/database/detail_model.dart';

abstract class CloudOperations {
  Future<void> createDetails(DetailsModel value);
  Future<void> getAllnotes();
}

class DetailsDB extends CloudOperations {
  DetailsDB._internal();
  static DetailsDB instance = DetailsDB._internal();
  DetailsDB factory() {
    return instance;
  }

  @override
  Future<void> createDetails(DetailsModel value) async {
    final detailsCollection =
        FirebaseFirestore.instance.collection('details').doc();
    final json = value.toJson();
    await detailsCollection.set(json);
  }

  @override
  Future<void> getAllnotes() async {
    await FirebaseFirestore.instance.collection('details').doc().get();
  }
}

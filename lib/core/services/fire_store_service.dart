import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    id,
  }) async {
    CollectionReference collectionName = _firestore.collection(path);
    await collectionName.doc(id).set(data);
  }

  Future<Map<String, dynamic>> getData({
    required String path,
    String? userName,
    Map<String, dynamic>? query,
  }) async {
    var data = await _firestore
        .collection(path)
        .where("username", isEqualTo: userName)
        .get();
    return data.docs.first.data();
  }

  Future<List<Map<String, dynamic>>> getDataList({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    Query<Map<String, dynamic>> data = _firestore.collection(path);
    if (query != null) {
      if (query['orderBy'] != null) {
        data = data.orderBy(query['orderBy'], descending: query['descending']);
      }
      if (query['limit'] != null) {
        data = data.limit(query['limit']);
      }
    }
    var result = await data.get();
    return result.docs.map((e) => e.data()).toList();
  }

  Future<bool> IsExist({required String path, required String docId}) async {
    var data = await _firestore.collection(path).doc(docId).get();
    return data.exists;
  }

  addDataToSubCollection({
    required String mainPath,
    required String subPath,
    required String mainId,
    required String subId,
    required Map<String, dynamic> data,
  }) async {
    CollectionReference collectionName = _firestore.collection(mainPath);
    await collectionName.doc(mainId).collection(subPath).doc(subId).set(data);
  }

  Future<List<Map<String, dynamic>>> getDataFromSubCollection({
    required String mainPath,
    required String subPath,
    required String mainId,
    Map<String, dynamic>? query,
  }) async {
    Query<Map<String, dynamic>> data = _firestore
        .collection(mainPath)
        .doc(mainId)
        .collection(subPath);
    if (query?['orderBy'] != null) {
      data = data.orderBy(query?['orderBy'], descending: query?['descending']);
    }
    if (query?['where'] != null) {
      data = data.where(query?['where'], isEqualTo: query?['value']);
    }
    var res = await data.get();
    return res.docs.map((e) => e.data()).toList();
  }

  deleteDataFromSubCollection({
    required String mainPath,
    required String subPath,
    required String mainId,
    required String subId,
  }) async {
    CollectionReference collectionName = _firestore.collection(mainPath);
    await collectionName.doc(mainId).collection(subPath).doc(subId).delete();
  }

  Future<void> updateFromSubCollection({
    required String mainPath,
    required String subPath,
    required String mainId,
    required String subId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(mainPath)
        .doc(mainId)
        .collection(subPath)
        .doc(subId)
        .update(data);
  }
}

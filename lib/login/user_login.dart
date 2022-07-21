import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserLogin {
  // Initialize connection with firebase
  final databaseReference = FirebaseFirestore.instance;
  final String COLLECTION = "users";

  // Add user (vendedor) to database
  Future<String> addUser(UserApp user) async {
    try {
      DocumentReference ref =
          await databaseReference.collection(COLLECTION).add(user.toMap());
      return "Usuário adicionado com sucesso";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<UserApp>> findAll() async {
    List<UserApp> listUsers = [];
    QuerySnapshot ref = await databaseReference.collection(COLLECTION).get();
    ref.docs.forEach((element) {
      listUsers.add(
          UserApp.fromJson(element.data() as Map<String, dynamic>, element.id));
    });
    return listUsers;
  }

  // Remove some user (vendedor) from the database
  Future<String> removeUser(String id) async {
    try {
      await databaseReference.collection(COLLECTION).doc(id).delete();
      return "Usuário excluído com sucesso";
    } catch (e) {
      return e.toString();
    }
  }

  // Verify if the user selected exists in the database
  Future<bool> verifyUser(UserApp user, String privilege) async {
    QuerySnapshot userInfo = await databaseReference
        .collection(COLLECTION)
        .where("email", isEqualTo: user.email)
        .where("privilege", isEqualTo: privilege)
        .get();
    return userInfo.docs.isNotEmpty;
  }
}

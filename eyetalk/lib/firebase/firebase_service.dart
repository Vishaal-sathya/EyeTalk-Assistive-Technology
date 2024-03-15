import 'package:firebase_database/firebase_database.dart';

class FirebaseStringService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Stream<String> getLatestString() {
    return _database.child('strings').limitToLast(1).onValue.map((event) {
      // Access the single child directly
      var data = event.snapshot.children.first.value;

      if (data is String) {
        return data;
      } else {
        return "";
      }
    });
  }
}

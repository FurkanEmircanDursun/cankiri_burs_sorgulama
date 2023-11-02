import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunction {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFirebaseWinner(String name, String surname, int tc) async {
    // Yeni bir döküman oluştur
    Map<String, dynamic> winnerData = {
      'name': name,
      'surname': surname,
      'tc': tc,
    };

    // "wins" koleksiyonuna yeni döküman ekle
    try {
      await _firestore.collection('wins').add(winnerData);
      print('Döküman eklendi.');
    } catch (e) {
      print('Döküman eklenirken bir hata oluştu: $e');
    }
  }

  Future<String> getWinnerByTc(int tc) async {
    var myQuery = await FirebaseFirestore.instance
        .collection('wins')
        .where('tc', isEqualTo: tc)
        .get();

    if (myQuery.size > 0) {
      return "${"Tebrikler " + myQuery.docs.first.data()['name']} " +
          myQuery.docs.first.data()['surname'];
    } else {
      return "Üzgünüz";
    }
  }
}

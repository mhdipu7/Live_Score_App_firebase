import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:live_football_score/data/model/football.dart';

class HomeScreenController extends GetxController {
  final db = FirebaseFirestore.instance;
  RxList<Football> matchList = <Football>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToFootballMatches();
  }

  void listenToFootballMatches() {
    db.collection('football').snapshots().listen(
      (data) {
        matchList.clear();
        for (var doc in data.docs) {
          matchList.add(
            Football(
              matchName: doc.id,
              team01Goal: doc.get('team01Goal'),
              team01Name: doc.get('team01Name'),
              team02Goal: doc.get('team02Goal'),
              team02Name: doc.get('team02Name'),
            ),
          );
        }
      },
    );
  }
}

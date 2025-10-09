import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/enum/chat_enum.dart';
import 'package:smart_construction_calculator/config/model/app_policies_model.dart';

class AppPolicyController extends GetxController {
  var isLoading = false.obs;
  var policy = Rxn<AppPolicyModel>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchPolicy(AppPolicy type) async {
    try {
      isLoading.value = true;

      String docId;
      switch (type) {
        case AppPolicy.privacy:
          docId = 'privacy';
          break;
        case AppPolicy.termsandconditoins:
          docId = 'terms_conditions';
          break;
      }

      final snapshot =
          await _firestore.collection('app_policies').doc(docId).get();

      if (snapshot.exists && snapshot.data() != null) {
        policy.value = AppPolicyModel.fromMap(snapshot.data()!);
      } else {
        policy.value = null;
      }
    } catch (e) {
      policy.value = null;
      print('❌ Error fetching policy: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

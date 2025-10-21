import 'dart:convert';
import 'package:crypto/crypto.dart'; // for md5 hash
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CompanyController extends GetxController {
  final companyData = Rxn<Map<String, dynamic>>();
  final isLoading = false.obs;
  final _storage = GetStorage();

  final String _cacheKey = 'companyData';
  final String _cacheHashKey = 'companyDataHash';

  @override
  void onInit() {
    super.onInit();
    loadCachedData();
    checkForChanges();
  }

  void loadCachedData() {
    final cached = _storage.read(_cacheKey);
    if (cached != null) {
      companyData.value = Map<String, dynamic>.from(cached);
      print('✅ Loaded cached company data');
    }
  }

  Future<void> checkForChanges() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse('https://construction-admin-api.vercel.app/company'),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final newData = jsonDecode(response.body);

        // Compute hash of new data
        final newHash = md5.convert(utf8.encode(jsonEncode(newData))).toString();
        final cachedHash = _storage.read(_cacheHashKey);

        if (cachedHash != newHash) {
          // Data changed, update local cache
          companyData.value = newData;
          _storage.write(_cacheKey, newData);
          _storage.write(_cacheHashKey, newHash);
          print('🔄 Company data changed — cache updated');
        } else {
          print('✅ Company data unchanged — using cached version');
        }
      } else {
        print('⚠️ Failed to fetch company data: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error checking company updates: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

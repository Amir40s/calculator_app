import 'dart:io';

abstract class BaseApiServices{
  Future<dynamic> getApi({required String url, var data});
  Future<dynamic> postApi({required String url,required var data});
  Future<dynamic> deleteApi({required String url,required var data});
  Future<dynamic> postUploadFile({
    required String url,
    required File file,
    Map<String, String>? extraData,
    Map<String, dynamic>? headers,
    required Function(int sent, int total) onSendProgress,
  });
  Future<dynamic> patchApi({required String url, required var data}); // ✅ PATCH method added

}
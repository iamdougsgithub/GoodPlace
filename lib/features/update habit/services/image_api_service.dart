import 'package:dio/dio.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/logger.dart';

class ImageApiService {
  String get _baseUrl =>
      "https://api.unsplash.com/search/photos?page=1&client_id=$_clientId";
  String get _clientId => "uFgQvpVkE15AFB8Jbfu-JyjoLkwkqR6qNcTjyZv1zHQ";
  Future<Map<String, dynamic>?> fetchPictures(String query) async {
    const String queryUrl = "&query=";
    try {
      final Response res = await Dio().get(_baseUrl + queryUrl + query);

      if (res.statusCode == 200) {
        return res.data;
      } else {
        return null;
      }
    } on DioException catch (dioErr) {
      logger.e(dioErr);
      Toast.errToast(
        title: dioErr.message,
      );
      return null;
    } catch (e) {
      logger.e(e);
      Toast.errToast(
        title: AppErrorText.errorMessageConverter(e.toString()),
      );
      return null;
    }
  }
}

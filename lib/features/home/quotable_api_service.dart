import 'package:dio/dio.dart';
import 'package:good_place/core/resourcers/error_texts.dart';
import 'package:good_place/core/utils/widgets/custom_toast.dart';
import 'package:good_place/features/home/quote_model.dart';

class ApiService {
  final String baseUrl = 'https://api.quotable.io';
  final Dio _dio = Dio();

  // Happiness tag'i ile rastgele bir alıntı alır
  Future<Quote> getRandomQuote() async {
    try {
      final String url = '$baseUrl/random?tags=happiness';
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        return Quote.fromJson(response.data);
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      Toast.errToast(title: AppErrorText.errorMessageConverter(e.toString()));
      throw Exception('Failed to load quote: $e');
    }
  }
}

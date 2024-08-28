import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatgptService {
  String url = dotenv.env['API_URL'] ?? 'API_URL not found';
  final String _apiKey = dotenv.env['API_KEY'] ?? 'API_KEY not found';

  Stream<String> getChatResponse(String requestBody) async* {
// ################  response dan dönen veriyi işleme
    Stream<String> checkAndProcessContent(
        Map<String, dynamic> data, String key, Duration delay) async* {
      if (data.containsKey(key)) {
        String content = data[key];
        // Metin daha kısa olması için
        content = content.replaceAll('\n', '').replaceAll('\n\n', '');

        if (content != null && content.isNotEmpty) {
          print('Content: $content');
          await Future.delayed(delay);

          yield content;
        } else {
          print('$key field is empty or null');
        }
      } else {
        print('$key field is missing');
      }
    }

// ###############
    final headers = {
      'Content-Type': 'application/json',
      'api-key': _apiKey,
    };

    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = requestBody;

    var streamedResponse = await request.send();

    await for (var line in streamedResponse.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      if (line.isNotEmpty && line != "data: [DONE]") {
        line = line.startsWith('data: ') ? line.substring(5) : line;

        final jsonData = jsonDecode(line);

        final choices = jsonData['choices'] as List<dynamic>;

        if (choices.isNotEmpty) {
          final firstChoice = choices[0];
          // "stream": false => 'message'
          if (firstChoice.containsKey('message')) {
            final message = firstChoice['message'] as Map<String, dynamic>;
            yield* checkAndProcessContent(
                message, 'content', Duration(milliseconds: 2));
          }

          // "stream": true => 'delta'
          if (firstChoice.containsKey('delta')) {
            final delta = firstChoice['delta'] as Map<String, dynamic>;
            yield* checkAndProcessContent(
                delta, 'content', Duration(milliseconds: 2));
          }
/*  Bu kısım [checkAndProcessContent] fonksiyon haline getirilmiştir.
        // 'delta' alanının var olup olmadığını kontrol et
        if (firstChoice.containsKey('message')) {
          final message = firstChoice['message'] as Map<String, dynamic>;

          // 'content' alanının var olup olmadığını ve boş olup olmadığını kontrol et
          if (message.containsKey('content')) {
            final content = message['content'];
            if (content != null && content.isNotEmpty) {
              print('Content: $content');
              await Future.delayed(Duration(milliseconds: 2));
              print("$i = $line ");
              i++;
              yield content;
            } else {
              print('Content field is empty or null');
            }
          } else {
            print('Content field is missing');
          }
        }

        // 'delta' alanının var olup olmadığını kontrol et
        if (firstChoice.containsKey('delta')) {
          final delta = firstChoice['delta'] as Map<String, dynamic>;

          // 'content' alanının var olup olmadığını ve boş olup olmadığını kontrol et
          if (delta.containsKey('content')) {
            final content = delta['content'];
            if (content != null && content.isNotEmpty) {
              print('Content: $content');
              await Future.delayed(Duration(milliseconds: 1));
              print("$i = $line ");
              i++;
              yield content;
            } else {
              print('Content field is empty or null');
            }
          } else {
            print('Content field is missing');
          }
        } 
        */
          else {
            print('Delta field is missing');
          }
        } else {
          print('Choices list is empty');
        }
      }
    }
  }

  String getApiBody({
    required String systemContentText,
    String? userContentText,
    String? imageUrl,
  }) {
    return jsonEncode({
      "messages": _buildMessages(systemContentText, userContentText, imageUrl),
      "temperature": 0.8,
      "top_p": 0.95,
      "max_tokens": 800,
      "stream": true,
    });
  }

  List<Map<String, dynamic>> _buildMessages(
    String systemContentText,
    String? userContentText,
    String? imageUrl,
  ) {
    List<Map<String, dynamic>> messages = [
      {
        "role": "system",
        "content": [
          {"type": "text", "text": systemContentText}
        ]
      }
    ];

    if ((userContentText != null && userContentText.isNotEmpty) ||
        (imageUrl != null && imageUrl.isNotEmpty)) {
      List<Map<String, dynamic>> userContent = [];

      if (userContentText != null && userContentText.isNotEmpty) {
        userContent.add({"type": "text", "text": userContentText});
      }

      if (imageUrl != null && imageUrl.isNotEmpty) {
        userContent.add({
          "type": "image_url",
          "image_url": {"url": imageUrl}
        });
      }

      messages.add({"role": "user", "content": userContent});
    }

    return messages;
  }
}

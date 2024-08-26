import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatgptService {
  String url = dotenv.env['API_URL'] ?? 'API_URL not found';
  String _apiKey = dotenv.env['API_KEY'] ?? 'API_KEY not found';

  Future<void> generateResponse(
      String userContentText,
      String systemContentText,
      TextEditingController controller,
      Function func) async {
    controller.clear();

    var response = '';
    ChatgptService()
        .getChatResponse(userContentText, systemContentText)
        .listen((word) {
      func(word);
    });
  }

  Stream<String> getChatResponse(
      String userContentText, String systemContentText) async* {
// response dan dönen veriyi işleme
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

    final headers = {
      'Content-Type': 'application/json',
      'api-key': _apiKey,
    };

    final body = _getApiBody([
      {
        "role": "system",
        "content": [
          {"type": "text", "text": systemContentText}
        ]
      },
      {
        "role": "user",
        "content": [
          {"type": "text", "text": userContentText}
        ]
      }
    ]);

    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = body;

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

  String _getApiBody(List<dynamic> jsonBody) {
    return jsonEncode({
      "messages": jsonBody,
      "temperature": 0.8,
      "top_p": 0.95,
      "max_tokens": 800,
      "stream": true,
    });
  }
}

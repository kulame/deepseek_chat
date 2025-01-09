import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deepseek_service.g.dart';

class DeepSeekService {
  final String baseUrl;
  final String apiKey;
  final http.Client _client;

  DeepSeekService({
    this.baseUrl =
        'https://api.deepseek.com', // Replace with actual API endpoint
    required this.apiKey,
  }) : _client = http.Client();

  Future<Map<String, dynamic>> sendMessage(String message) async {
    var url = Uri.parse('$baseUrl/chat/completions');
    print("url: $url");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    print("headers: $headers");

    try {
      final response = await _client.post(
        url,
        headers: headers,
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'user', 'content': message}
          ],
          'temperature': 0.7,
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        //return jsonDecode(response.body);
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}

@riverpod
DeepSeekService deepSeekService(DeepSeekServiceRef ref) {
  final service = DeepSeekService(
    apiKey: const String.fromEnvironment('DEEPSEEK_API_KEY'),
  );
  ref.onDispose(() => service.dispose());
  return service;
}

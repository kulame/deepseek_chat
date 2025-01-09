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

    int maxAttempts = 3;
    int attempt = 0;
    Duration baseDelay = const Duration(seconds: 1);

    while (attempt < maxAttempts) {
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

        if (response.statusCode == 200) {
          return jsonDecode(utf8.decode(response.bodyBytes));
        } else {
          throw Exception('Failed to send message: ${response.statusCode}');
        }
      } catch (e) {
        attempt++;
        if (attempt == maxAttempts) {
          throw Exception('Network error after $maxAttempts attempts: $e');
        }
        
        // Calculate delay with exponential backoff
        var delay = baseDelay * (1 << (attempt - 1));
        print('Attempt $attempt failed. Retrying in ${delay.inSeconds} seconds...');
        await Future.delayed(delay);
      }
    }
    
    // This should never be reached due to the throw in the catch block
    throw Exception('Unexpected error in retry logic');
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

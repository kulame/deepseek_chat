import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deepseek_service.g.dart';

class DeepSeekService {
  final String baseUrl;
  final String apiKey;
  final http.Client _client;

  DeepSeekService({
    this.baseUrl = 'https://api.deepseek.com/v1',  // Replace with actual API endpoint
    required this.apiKey,
  }) : _client = http.Client();

  Future<Map<String, dynamic>> sendMessage(String message) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'user', 'content': message}
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
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

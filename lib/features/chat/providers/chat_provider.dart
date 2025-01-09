import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';
import '../../../core/services/deepseek_service.dart';

part 'chat_provider.g.dart';

const _uuid = Uuid();

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  List<ChatMessage> build() {
    return [
      ChatMessage(
        id: _uuid.v4(),
        content: '👋你好呀，我是 Kimi，很高兴认识你！有问题欢迎随时问我。',
        isUser: false,
      ),
    ];
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: _uuid.v4(),
      content: content,
      isUser: true,
    );

    state = [...state, userMessage];

    try {
      final deepSeekService = ref.read(deepSeekServiceProvider);
      final response = await deepSeekService.sendMessage(content);
      
      final assistantMessage = ChatMessage(
        id: _uuid.v4(),
        content: response['choices'][0]['message']['content'],
        isUser: false,
      );

      state = [...state, assistantMessage];
    } catch (e) {
      final errorMessage = ChatMessage(
        id: _uuid.v4(),
        content: '抱歉，发生了一些错误。请稍后再试。',
        isUser: false,
      );

      state = [...state, errorMessage];
    }
  }
}

@riverpod
class ChatInput extends _$ChatInput {
  @override
  String build() => '';

  void updateInput(String value) {
    state = value;
  }

  void clear() {
    state = '';
  }
}

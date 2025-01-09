import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ChatScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kimi Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4B6BFB),
          primary: const Color(0xFF4B6BFB),
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer
          },
        ),
        title: const Text('Kimi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_off),
            onPressed: () {
              // TODO: Implement mute
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // TODO: Implement message action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ChatBubble(
                  isUser: false,
                  message: '👋你好呀，我是 Kimi，很高兴认识你！有问题欢迎随时问我。',
                ),
                SizedBox(height: 16),
                QuickActionCard(
                  title: 'Kimi k1 视觉思考模型',
                  subtitle: '抢先体验',
                  icon: '🔥',
                ),
              ],
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: isUser ? 48 : 0,
        right: isUser ? 0 : 48,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser 
          ? Theme.of(context).colorScheme.primary 
          : Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isUser 
            ? Colors.white 
            : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;

  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(icon, style: const TextStyle(fontSize: 24)),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          // TODO: Implement quick action
        },
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              // TODO: Implement photo upload
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // TODO: Implement phone call
            },
          ),
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              // TODO: Implement translation
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement writing
            },
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '有什么问题尽管问我',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              // TODO: Implement voice input
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: Implement additional options
            },
          ),
        ],
      ),
    );
  }
}

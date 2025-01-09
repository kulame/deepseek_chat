// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatNotifierHash() => r'1f83daf4ec45e7d601dfbc57c58694cf9205edd2';

/// See also [ChatNotifier].
@ProviderFor(ChatNotifier)
final chatNotifierProvider =
    AutoDisposeNotifierProvider<ChatNotifier, List<ChatMessage>>.internal(
  ChatNotifier.new,
  name: r'chatNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatNotifier = AutoDisposeNotifier<List<ChatMessage>>;
String _$chatInputHash() => r'72dc13be5bc27b65214ca89824d9e9cce4e2525b';

/// See also [ChatInput].
@ProviderFor(ChatInput)
final chatInputProvider =
    AutoDisposeNotifierProvider<ChatInput, String>.internal(
  ChatInput.new,
  name: r'chatInputProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatInputHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatInput = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

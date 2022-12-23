library easy_emoji;

import 'dart:async';

import 'package:flutter/services.dart';

typedef Handler = void Function(String text);
typedef Replacer = String Function(String text);

Emoji emoji = Emoji._instance;

class Emoji {
  Emoji._() {
    _readFromAssets().then((value) {
      _root = value;
      _completer.complete();
    });
  }

  final Completer _completer = Completer();

  late final _root;

  Future waitInit() async {
    return _completer.future;
  }

  static final Emoji _instance = Emoji._();

  Future<_Node> _readFromAssets() async {
    final root = _Node.root();
    final seqFile = await rootBundle
        .loadString("packages/easy_emoji/assets/emoji-sequences.txt");
    _convertFileToTrie(seqFile, root);

    final zwjFile = await rootBundle
        .loadString("packages/easy_emoji/assets/emoji-zwj-sequences.txt");
    _convertFileToTrie(zwjFile, root);

    return root;
  }

  void _convertFileToTrie(String data, _Node root) {
    final l = data
        .split("\n")
        .where((element) => element.isNotEmpty && !element.startsWith("#"))
        .map((e) => e.split(";").first.trim());
    for (final i in l) {
      if (i.contains("..")) {
        final range = i.split("..");
        final start = int.parse(range.first, radix: 16);
        final end = int.parse(range.last, radix: 16);
        for (int j = start; j <= end; j++) {
          root.addNode(j, true);
        }
      } else {
        var node = root;
        final codeList = i.split(" ");
        for (int j = 0; j < codeList.length; j++) {
          final code = int.parse(codeList[j], radix: 16);
          node.addNode(code, j == codeList.length - 1);
          node = node.getNode(code)!;
        }
      }
    }
  }

  /// Handle every emoji and text in the text.
  void handleAll(String str, {Handler? emojiHandler, Handler? textHandler}) {
    _Node? next = _root;
    int startText = 0;
    int endText = 0;
    bool inEmoji = false;
    int startEmoji = 0;
    int endEmoji = 0;
    bool isEmoji = false;

    final text = str.runes.toList();

    for (int i = 0; i < text.length; i++) {
      final code = text[i];
      next = next!.getNode(code);
      if (next != null) {
        if (!inEmoji) {
          startEmoji = i;
        }
        inEmoji = true;
        isEmoji = next.isEnd;
      }
      if (next == null && inEmoji) {
        inEmoji = false;
        if (isEmoji) {
          endEmoji = i;
          textHandler
              ?.call(String.fromCharCodes(text.sublist(startText, endText)));
          emojiHandler
              ?.call(String.fromCharCodes(text.sublist(startEmoji, endEmoji)));
          startText = i;
        }
        isEmoji = false;
        endText = i;
      }
      if (next == null) {
        next = _root;
        final nextNode = next!.getNode(code);
        if (nextNode != null) {
          next = nextNode;
          if (!inEmoji) {
            startEmoji = i;
          }
          inEmoji = true;
          isEmoji = next.isEnd;
        }
      }
      if (!inEmoji) {
        endText = i + 1;
      }
    }
    // handle last emoji
    if (inEmoji && next != null && next.isEnd) {
      textHandler?.call(String.fromCharCodes(text.sublist(startText, endText)));
      endEmoji = text.length;
      emojiHandler
          ?.call(String.fromCharCodes(text.sublist(startEmoji, endEmoji)));
      textHandler?.call(String.fromCharCodes(text.sublist(endEmoji)));
    } else {
      textHandler?.call(String.fromCharCodes(text.sublist(startText)));
    }
  }

  /// Replace all emoji and text in the text with the replacer.
  String replace(String str,
      {Replacer? emojiReplacer, Replacer? textReplacer}) {
    final result = StringBuffer();
    handleAll(
      str,
      emojiHandler: emojiReplacer != null
          ? (emoji) => result.write(emojiReplacer(emoji))
          : (emoji) => result.write(emoji),
      textHandler: textReplacer != null
          ? (text) => result.write(textReplacer(text))
          : (text) => result.write(text),
    );
    return result.toString();
  }

  /// Return all emoji in the text.
  /// if [removeEmoji] is true, the emoji will be removed from the text, else the text will be removed.
  String remove(String str, {bool removeEmoji = true}) {
    final result = StringBuffer();
    handleAll(
      str,
      emojiHandler: removeEmoji ? null : (emoji) => result.write(emoji),
      textHandler: removeEmoji ? (text) => result.write(text) : null,
    );
    return result.toString();
  }

  /// Split the text into emoji and text.
  List<String> split(String str, {bool withEmoji = true}) {
    final List<String> resultList = [];
    handleAll(str, emojiHandler: (emoji) {
      if (withEmoji) {
        resultList.add(emoji);
      }
    }, textHandler: (text) {
      resultList.add(text);
    });
    return resultList;
  }

  /// Count the emoji in the text.
  int countEmoji(String str) {
    int count = 0;
    handleAll(str, emojiHandler: (emoji) {
      count++;
    });
    return count;
  }
}

extension EmojiExt on String {
  String replaceWithEmoji({Replacer? emojiReplacer, Replacer? textReplacer}) {
    return emoji.replace(this,
        emojiReplacer: emojiReplacer, textReplacer: textReplacer);
  }

  String removeWithEmoji({bool removeEmoji = true}) {
    return emoji.remove(this, removeEmoji: removeEmoji);
  }

  List<String> splitWithEmoji({bool withEmoji = true}) {
    return emoji.split(this, withEmoji: withEmoji);
  }

  int countEmoji() {
    return emoji.countEmoji(this);
  }
}

class _Node {
  final int codePoint;
  final bool isEnd;
  final Map<int, _Node> nodeMap;

  _Node._(this.codePoint, this.isEnd, this.nodeMap);

  factory _Node.root() => _Node._(0, false, {});

  void addNode(int codePoint, bool isEnd) {
    if (nodeMap[codePoint] == null) {
      nodeMap[codePoint] = _Node._(codePoint, isEnd, {});
    } else {
      return;
    }
  }

  _Node? getNode(int codePoint) => nodeMap[codePoint];

  @override
  String toString() =>
      "Node{codePoint: $codePoint, isEnd: $isEnd, nodeMap: $nodeMap}";
}

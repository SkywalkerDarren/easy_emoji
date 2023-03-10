# Example

Use function:

```dart
void example() {
  var str = "Hið emoji";
  final s1 = emoji.replace(
      str, emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  print(s1); // {Hi}(ð){ emoji}
  final s2 = emoji.remove(str, removeEmoji: true);
  print(s2); // Hi emoji
  final strList = emoji.split(str, withEmoji: true);
  print(strList); // ["Hi", "ð", " emoji"]
  final count = emoji.countEmoji(str);
  print(count); // 1
  
  emoji.handleAll(
    str, 
    emojiHandler: (emoji) {
      // do something with emoji
      print(emoji);
    }, textHandler: (text) {
      // do something with text
      print(text);
    },
  );
  // Hi
  // ð
  //  emoji
}
```

Use extension:

```dart
void example() {
  var str = "Hið emoji";
  final s1 = str.replaceWithEmoji(
      emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  print(s1); // {Hi}(ð){ emoji}
  final s2 = str.replaceWithEmoji(emojiReplacer: (emoji) => "#");
  print(s2); // Hi# emoji
  final s3 = str.replaceWithEmoji(textReplacer: (text) => "#");
  print(s3); // #ð#
  final s4 = str.removeWithEmoji();
  print(s4); // Hi emoji
  final s5 = str.removeWithEmoji(removeEmoji: false);
  print(s5); // ð
  final strList = str.splitWithEmoji();
  print(strList); // ["Hi", "ð", " emoji"]
  final count = str.countEmoji();
  print(count); // 1
}
```

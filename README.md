πFast and β¨simple way to handle text with πemoji.

Support unicode emoji 15.0

## Getting started

Add this into `pubspec.yaml`

```yaml
dependencies:
  easy_emoji: ^1.0.2
```

## Usage

Easy to use:

```dart
import 'package:easy_emoji/easy_emoji.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // wait for emoji data loaded, must call WidgetsFlutterBinding.ensureInitialized() before init.
  await emoji.waitInit();
  print(emoji.remove("Hiπ emoji")); // Hi emoji
  print("Hiπ emoji".removeWithEmoji()); // Hi emoji
  runApp(MyApp());
}
```

## Example

Use function:

```dart
void example() {
  var str = "Hiπ emoji";
  final s1 = emoji.replace(
      str, emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  print(s1); // {Hi}(π){ emoji}
  final s2 = emoji.remove(str, removeEmoji: true);
  print(s2); // Hi emoji
  final strList = emoji.split(str, withEmoji: true);
  print(strList); // ["Hi", "π", " emoji"]
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
  // π
  //  emoji
}
```

Use extension:

```dart
void example() {
  var str = "Hiπ emoji";
  final s1 = str.replaceWithEmoji(
      emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  print(s1); // {Hi}(π){ emoji}
  final s2 = str.replaceWithEmoji(emojiReplacer: (emoji) => "#");
  print(s2); // Hi# emoji
  final s3 = str.replaceWithEmoji(textReplacer: (text) => "#");
  print(s3); // #π#
  final s4 = str.removeWithEmoji();
  print(s4); // Hi emoji
  final s5 = str.removeWithEmoji(removeEmoji: false);
  print(s5); // π
  final strList = str.splitWithEmoji();
  print(strList); // ["Hi", "π", " emoji"]
  final count = str.countEmoji();
  print(count); // 1
}
```

## License

MIT License

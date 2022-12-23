🚀Fast and ✨simple way to handle text with 👍emoji.

Support unicode emoji 15.0

## Getting started

Add this into `pubspec.yaml`
```yaml
dependencies:
  easy_emoji: ^1.0.0
```

## Usage

Easy to use:

```dart
import 'package:easy_emoji/easy_emoji.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // wait for emoji data loaded, must call WidgetsFlutterBinding.ensureInitialized() before init.
  await emoji.waitInit();
  print(emoji.remove("Hi😀 emoji")); // Hi emoji
  print("Hi😀 emoji".removeWithEmoji()); // Hi emoji
  runApp(MyApp());
}
```

## Example

Use function:

```dart
void example() {
  var str = "Hi😀 emoji";
  str = emoji.replace(str, emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  str = emoji.remove(str, removeEmoji: true);
  final strList = emoji.split(str, withEmoji: true);
  final count = emoji.countEmoji(str);
  
  emoji.handleAll(str, emojiHandler: (emoji) => print(emoji), textHandler: (text) => print(text));
}
```

Use extension:

```dart
void example() {
  var str = "Hi😀 emoji";
  str = str.replaceWithEmoji(emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}");
  str = str.replaceWithEmoji(emojiReplacer: (emoji) => "#");
  str = str.replaceWithEmoji(textReplacer: (text) => "#");
  str = str.removeWithEmoji();
  str = str.removeWithEmoji(removeEmoji: false);
  final strList = str.splitWithEmoji();
  final count = str.countEmoji();
}
```

## License

MIT License

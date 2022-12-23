import 'package:easy_emoji/easy_emoji.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('emoji', () async {
    await emoji.waitInit();
    final testList = [
      {
        "input": "!@#😀123",
        "replace_output": "{!@#}(😀){123}",
        "replaceEmoji_output": "!@##123",
        "replaceText_output": "#😀#",
        "removeEmoji_output": "!@#123",
        "removeText_output": "😀",
        "countEmoji_output": 1,
      },
      {
        "input": "",
        "replace_output": "{}",
        "replaceEmoji_output": "",
        "replaceText_output": "#",
        "removeEmoji_output": "",
        "removeText_output": "",
        "countEmoji_output": 0,
      },
      {
        "input": "!",
        "replace_output": "{!}",
        "replaceEmoji_output": "!",
        "replaceText_output": "#",
        "removeEmoji_output": "!",
        "removeText_output": "",
        "countEmoji_output": 0,
      },
      {
        "input": "!@#",
        "replace_output": "{!@#}",
        "replaceEmoji_output": "!@#",
        "replaceText_output": "#",
        "removeEmoji_output": "!@#",
        "removeText_output": "",
        "countEmoji_output": 0,
      },
      {
        "input": "😄",
        "replace_output": "{}(😄){}",
        "replaceEmoji_output": "#",
        "replaceText_output": "#😄#",
        "removeEmoji_output": "",
        "removeText_output": "😄",
        "countEmoji_output": 1,
      },
      {
        "input": "Hello, world! 😄",
        "replace_output": "{Hello, world! }(😄){}",
        "replaceEmoji_output": "Hello, world! #",
        "replaceText_output": "#😄#",
        "removeEmoji_output": "Hello, world! ",
        "removeText_output": "😄",
        "countEmoji_output": 1,
      },
      {
        "input": "👋(👨‍👩‍👧‍👧)(👨‍👩‍👧)(🧑‍🦳,🧑‍🦳",
        "replace_output": "{}(👋){(}(👨‍👩‍👧‍👧){)(}(👨‍👩‍👧){)(}(🧑‍🦳){,}(🧑‍🦳){}",
        "replaceEmoji_output": "#(#)(#)(#,#",
        "replaceText_output": "#👋#👨‍👩‍👧‍👧#👨‍👩‍👧#🧑‍🦳#🧑‍🦳#",
        "removeEmoji_output": "()()(,",
        "removeText_output": "👋👨‍👩‍👧‍👧👨‍👩‍👧🧑‍🦳🧑‍🦳",
        "countEmoji_output": 5,
      },
      {
        "input": "👋(👨‍👩‍👧‍👧)(👨‍👩‍👧)(🧑‍🦳🧑‍🦳",
        "replace_output": "{}(👋){(}(👨‍👩‍👧‍👧){)(}(👨‍👩‍👧){)(}(🧑‍🦳){}(🧑‍🦳){}",
        "replaceEmoji_output": "#(#)(#)(##",
        "replaceText_output": "#👋#👨‍👩‍👧‍👧#👨‍👩‍👧#🧑‍🦳#🧑‍🦳#",
        "removeEmoji_output": "()()(",
        "removeText_output": "👋👨‍👩‍👧‍👧👨‍👩‍👧🧑‍🦳🧑‍🦳",
        "countEmoji_output": 5,
      },
      {
        "input": "👋(👨‍👩‍👧‍👧)(👨‍👩‍👧)(🧑‍🦳🧑‍🦳)",
        "replace_output": "{}(👋){(}(👨‍👩‍👧‍👧){)(}(👨‍👩‍👧){)(}(🧑‍🦳){}(🧑‍🦳){)}",
        "replaceEmoji_output": "#(#)(#)(##)",
        "replaceText_output": "#👋#👨‍👩‍👧‍👧#👨‍👩‍👧#🧑‍🦳#🧑‍🦳#",
        "removeEmoji_output": "()()()",
        "removeText_output": "👋👨‍👩‍👧‍👧👨‍👩‍👧🧑‍🦳🧑‍🦳",
        "countEmoji_output": 5,
      },
      {
        "input": "(👋👨‍👩‍👧‍👧)(👨‍👩‍👧)(🧑‍🦳🧑‍🦳)",
        "replace_output": "{(}(👋){}(👨‍👩‍👧‍👧){)(}(👨‍👩‍👧){)(}(🧑‍🦳){}(🧑‍🦳){)}",
        "replaceEmoji_output": "(##)(#)(##)",
        "replaceText_output": "#👋#👨‍👩‍👧‍👧#👨‍👩‍👧#🧑‍🦳#🧑‍🦳#",
        "removeEmoji_output": "()()()",
        "removeText_output": "👋👨‍👩‍👧‍👧👨‍👩‍👧🧑‍🦳🧑‍🦳",
        "countEmoji_output": 5,
      },
      {
        "input": "🧑‍🦳🧑‍🦳👋👨‍👩‍👧‍👧",
        "replace_output": "{}(🧑‍🦳){}(🧑‍🦳){}(👋){}(👨‍👩‍👧‍👧){}",
        "replaceEmoji_output": "####",
        "replaceText_output": "#🧑‍🦳#🧑‍🦳#👋#👨‍👩‍👧‍👧#",
        "removeEmoji_output": "",
        "removeText_output": "🧑‍🦳🧑‍🦳👋👨‍👩‍👧‍👧",
        "countEmoji_output": 4,
      },
      {
        "input": "🥯 Hi 🥰",
        "replace_output": "{}(🥯){ Hi }(🥰){}",
        "replaceEmoji_output": "# Hi #",
        "replaceText_output": "#🥯#🥰#",
        "removeEmoji_output": " Hi ",
        "removeText_output": "🥯🥰",
        "countEmoji_output": 2,
      },
    ];
    for (var test in testList) {
      final input = test["input"]! as String;
      expect(
        input.replaceWithEmoji(emojiReplacer: (emoji) => "($emoji)", textReplacer: (text) => "{$text}"),
        test["replace_output"]!,
      );
      expect(
        input.replaceWithEmoji(emojiReplacer: (emoji) => "#"),
        test["replaceEmoji_output"]!,
      );
      expect(
        input.replaceWithEmoji(textReplacer: (text) => "#"),
        test["replaceText_output"]!,
      );
      expect(
        input.removeWithEmoji(),
        test["removeEmoji_output"]!,
      );
      expect(
        input.removeWithEmoji(removeEmoji: false),
        test["removeText_output"]!,
      );
      expect(
        input.countEmoji(),
        test["countEmoji_output"]!,
      );
    }
  });
}

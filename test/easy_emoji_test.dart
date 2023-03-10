import 'package:easy_emoji/easy_emoji.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('emoji', () async {
    await emoji.waitInit();
    final testList = [
      {
        "input": "!@#๐123",
        "replace_output": "{!@#}(๐){123}",
        "replaceEmoji_output": "!@##123",
        "replaceText_output": "#๐#",
        "removeEmoji_output": "!@#123",
        "removeText_output": "๐",
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
        "input": "๐",
        "replace_output": "{}(๐){}",
        "replaceEmoji_output": "#",
        "replaceText_output": "#๐#",
        "removeEmoji_output": "",
        "removeText_output": "๐",
        "countEmoji_output": 1,
      },
      {
        "input": "Hello, world! ๐",
        "replace_output": "{Hello, world! }(๐){}",
        "replaceEmoji_output": "Hello, world! #",
        "replaceText_output": "#๐#",
        "removeEmoji_output": "Hello, world! ",
        "removeText_output": "๐",
        "countEmoji_output": 1,
      },
      {
        "input": "๐(๐จโ๐ฉโ๐งโ๐ง)(๐จโ๐ฉโ๐ง)(๐งโ๐ฆณ,๐งโ๐ฆณ",
        "replace_output":
            "{}(๐){(}(๐จโ๐ฉโ๐งโ๐ง){)(}(๐จโ๐ฉโ๐ง){)(}(๐งโ๐ฆณ){,}(๐งโ๐ฆณ){}",
        "replaceEmoji_output": "#(#)(#)(#,#",
        "replaceText_output": "#๐#๐จโ๐ฉโ๐งโ๐ง#๐จโ๐ฉโ๐ง#๐งโ๐ฆณ#๐งโ๐ฆณ#",
        "removeEmoji_output": "()()(,",
        "removeText_output": "๐๐จโ๐ฉโ๐งโ๐ง๐จโ๐ฉโ๐ง๐งโ๐ฆณ๐งโ๐ฆณ",
        "countEmoji_output": 5,
      },
      {
        "input": "๐(๐จโ๐ฉโ๐งโ๐ง)(๐จโ๐ฉโ๐ง)(๐งโ๐ฆณ๐งโ๐ฆณ",
        "replace_output":
            "{}(๐){(}(๐จโ๐ฉโ๐งโ๐ง){)(}(๐จโ๐ฉโ๐ง){)(}(๐งโ๐ฆณ){}(๐งโ๐ฆณ){}",
        "replaceEmoji_output": "#(#)(#)(##",
        "replaceText_output": "#๐#๐จโ๐ฉโ๐งโ๐ง#๐จโ๐ฉโ๐ง#๐งโ๐ฆณ#๐งโ๐ฆณ#",
        "removeEmoji_output": "()()(",
        "removeText_output": "๐๐จโ๐ฉโ๐งโ๐ง๐จโ๐ฉโ๐ง๐งโ๐ฆณ๐งโ๐ฆณ",
        "countEmoji_output": 5,
      },
      {
        "input": "๐(๐จโ๐ฉโ๐งโ๐ง)(๐จโ๐ฉโ๐ง)(๐งโ๐ฆณ๐งโ๐ฆณ)",
        "replace_output":
            "{}(๐){(}(๐จโ๐ฉโ๐งโ๐ง){)(}(๐จโ๐ฉโ๐ง){)(}(๐งโ๐ฆณ){}(๐งโ๐ฆณ){)}",
        "replaceEmoji_output": "#(#)(#)(##)",
        "replaceText_output": "#๐#๐จโ๐ฉโ๐งโ๐ง#๐จโ๐ฉโ๐ง#๐งโ๐ฆณ#๐งโ๐ฆณ#",
        "removeEmoji_output": "()()()",
        "removeText_output": "๐๐จโ๐ฉโ๐งโ๐ง๐จโ๐ฉโ๐ง๐งโ๐ฆณ๐งโ๐ฆณ",
        "countEmoji_output": 5,
      },
      {
        "input": "(๐๐จโ๐ฉโ๐งโ๐ง)(๐จโ๐ฉโ๐ง)(๐งโ๐ฆณ๐งโ๐ฆณ)",
        "replace_output":
            "{(}(๐){}(๐จโ๐ฉโ๐งโ๐ง){)(}(๐จโ๐ฉโ๐ง){)(}(๐งโ๐ฆณ){}(๐งโ๐ฆณ){)}",
        "replaceEmoji_output": "(##)(#)(##)",
        "replaceText_output": "#๐#๐จโ๐ฉโ๐งโ๐ง#๐จโ๐ฉโ๐ง#๐งโ๐ฆณ#๐งโ๐ฆณ#",
        "removeEmoji_output": "()()()",
        "removeText_output": "๐๐จโ๐ฉโ๐งโ๐ง๐จโ๐ฉโ๐ง๐งโ๐ฆณ๐งโ๐ฆณ",
        "countEmoji_output": 5,
      },
      {
        "input": "๐งโ๐ฆณ๐งโ๐ฆณ๐๐จโ๐ฉโ๐งโ๐ง",
        "replace_output": "{}(๐งโ๐ฆณ){}(๐งโ๐ฆณ){}(๐){}(๐จโ๐ฉโ๐งโ๐ง){}",
        "replaceEmoji_output": "####",
        "replaceText_output": "#๐งโ๐ฆณ#๐งโ๐ฆณ#๐#๐จโ๐ฉโ๐งโ๐ง#",
        "removeEmoji_output": "",
        "removeText_output": "๐งโ๐ฆณ๐งโ๐ฆณ๐๐จโ๐ฉโ๐งโ๐ง",
        "countEmoji_output": 4,
      },
      {
        "input": "๐ฅฏ Hi ๐ฅฐ",
        "replace_output": "{}(๐ฅฏ){ Hi }(๐ฅฐ){}",
        "replaceEmoji_output": "# Hi #",
        "replaceText_output": "#๐ฅฏ#๐ฅฐ#",
        "removeEmoji_output": " Hi ",
        "removeText_output": "๐ฅฏ๐ฅฐ",
        "countEmoji_output": 2,
      },
    ];
    for (var test in testList) {
      final input = test["input"]! as String;
      expect(
        input.replaceWithEmoji(
            emojiReplacer: (emoji) => "($emoji)",
            textReplacer: (text) => "{$text}"),
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

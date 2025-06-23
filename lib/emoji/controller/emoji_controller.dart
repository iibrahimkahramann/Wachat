import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> emojis = [
  '•_•',
  '(^_^)',
  '(^o^)',
  '(-_-)',
  '(-.-)Zzz',
  '(o_o)',
  '(*^_^*)',
  '(^_~)',
  '(╯°□°）╯︵ ┻━┻',
  '(╥_╥)',
  '٩(◕‿◕｡)۶',
  '(°_°)',
  '(´･ω･`)',
  '(¬‿¬)',
  '(╯‵□′)╯︵┻━┻',
  '( ಠ ʖ̯ ಠ )',
  '༼ つ ◕_◕ ༽つ',
  '⊙_☉',
  '(∘❛ᴗ❛∘)',
  '(¬_¬)',
  '¯\\_(ツ)_/¯',
  'ヽ(＾Д＾)ﾉ',
  '(｡♥‿♥｡)',
  'ಠ_ಠ',
  '(*≧ω≦)',
  '૮₍ ´• ˕ •`₎ა',
  '(･ω･)',
  '(｡•́‿•̀｡)',
  'ヽ(・∀・)ﾉ',
  '✧(｡•̀ᴗ-)✧',
  'ヽ( ´ ▽ ` )ﾉ',
  'ლ(╹◡╹ლ)',
  '☆*:.｡.o(≧▽≦)o.｡.:*☆',
  'ʕ•́ᴥ•̀ʔ',
  'ヽ(´▽｀)ノ',
  '(*≧▽≦)',
  '(´｡• ᵕ •｡`)',
  'ლ(・﹏・ლ)',
  'ฅ^•ﻌ•^ฅ',
  '(´∩｡• ᵕ •｡∩`)',
  '(*˘︶˘*)',
  '(◠‿◠)',
  '୧(﹒︠‿﹒︡)୨',
  '(づ｡◕‿‿◕｡)づ',
  '(￣ω￣)',
  '╰(°▽°)╯',
  '(｡•́‿•̀｡)',
  '(´｡• ᵕ •｡`)',
  '(っ˘ω˘ς)',
  '⊂(◉‿◉)つ',
  '（　ﾟДﾟ）',
  '(╯︵╰,)'
];

void copyEmoji(String emoji, BuildContext context) {
  Clipboard.setData(ClipboardData(text: emoji)).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$emoji kopyalandı!')),
    );
  });
}

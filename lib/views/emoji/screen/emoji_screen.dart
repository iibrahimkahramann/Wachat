import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wachat_new_package/controller/emoji_controller.dart';

class EmojiListScreen extends StatelessWidget {
  const EmojiListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => GoRouter.of(context).go('/home'),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.24),
          child: Text(
            'Emojis'.tr(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.02, width * 0.041, 0),
        child: ListView.builder(
          itemCount: emojis.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: height * 0.015),
              padding: EdgeInsets.all(height * 0.015),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    emojis[index],
                    style: TextStyle(fontSize: height * 0.024),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () => copyEmoji(emojis[index], context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

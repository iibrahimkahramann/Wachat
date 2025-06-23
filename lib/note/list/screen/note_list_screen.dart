import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/custom_theme.dart';
import '../../../providers/note_provider.dart';

class NoteListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/chevron-left.png',
              width: width * 0.06, color: Colors.black),
          onPressed: () => GoRouter.of(context).go('/private-note'),
        ),
        title: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.21),
          child: Text(
            'Note List'.tr(),
            style: CustomTheme.textTheme(context)
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.041, height * 0.02, width * 0.041, 0),
        child: notes.isEmpty
            ? Center(
                child: Text(
                  'No Note generated yet.'.tr(),
                  style: CustomTheme.textTheme(context)
                      .bodyMedium
                      ?.copyWith(color: Colors.grey[400]),
                ),
              )
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.go(
                        '/note-detail/$index',
                        extra: notes[index],
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: height * 0.015),
                      padding: EdgeInsets.all(height * 0.015),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notes[index].title.length > 20
                                ? '${notes[index].title.substring(0, 20)}...' // İlk 20 karakter ve "..."
                                : notes[index].title, // Tam başlık
                            style: CustomTheme.textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await ref
                                  .read(noteProvider.notifier)
                                  .deleteNote(index);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Note deleted!'.tr())),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

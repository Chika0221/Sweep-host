// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTrashboxPage extends HookConsumerWidget {
  const AddTrashboxPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultWidth = MediaQuery.of(context).size.width * 0.5;

    final sliberValue = useState<double>(10000);

    return Scaffold(
      appBar: AppBar(title: Text("ゴミ箱を追加"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: defaultWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("名前を入力"),
                    ),
                  ),
                  SizedBox(height: 16),
                  Slider(
                    value: sliberValue.value,
                    max: 1000000,
                    min: 1000,
                    divisions: 50,
                    onChanged: (value) {
                      sliberValue.value = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:sweep_host/pages/login_page/input_info_page.dart';
import 'package:sweep_host/pages/main_page.dart';
import 'package:sweep_host/states/login_notifier.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailState = useState<TextEditingController>(TextEditingController());
    final passwordState = useState<TextEditingController>(
      TextEditingController(),
    );

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/icons/sweep-hostIcon.png",
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
          ),
          SizedBox(
            width: 500,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*ログインフォーム*/
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      "ログイン",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(24.0), // Increased padding
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface.withOpacity(
                        0.95,
                      ), // Slight transparency
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // Slightly larger radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailState.value,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "メールアドレス",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.surfaceVariant.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 16), // Spacing
                        TextField(
                          controller: passwordState.value,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "パスワード",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: Theme.of(
                              context,
                            ).colorScheme.surfaceVariant.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24), // Spacing
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.login),
                            onPressed: () async {
                              final isSuccess = await ref
                                  .read(loginProvider.notifier)
                                  .signInWIthEmailAndPassword(
                                    emailState.value.text,
                                    passwordState.value.text,
                                  );
                              if (isSuccess == "") {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => MainPage(),
                                  ),
                                );
                              } else {
                                print(isSuccess);
                                String errorMessage = "ログインに失敗しました。";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                              }
                            },
                            label: const Text("ログイン"),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              final isSuccess = await ref
                                  .read(loginProvider.notifier)
                                  .signUpWithEmailAndPassword(
                                    emailState.value.text,
                                    passwordState.value.text,
                                  );
                              if (isSuccess == "") {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => InputInfoPage(
                                          email: emailState.value.text,
                                        ),
                                  ),
                                );
                              } else {
                                String errorMessage = "サインアップに失敗しました。";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                  ),
                                );
                              }
                            },
                            child: const Text("サインアップ"),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                              ),
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

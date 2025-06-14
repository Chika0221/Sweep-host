// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_network/image_network.dart';

// Project imports:
import 'package:sweep_host/classes/host.dart';
import 'package:sweep_host/states/host_provider.dart';
import 'package:sweep_host/states/login_notifier.dart';

class HostPlate extends HookConsumerWidget {
  const HostPlate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostProfile = ref.watch(hostProvider);
    final login = ref.watch(loginProvider);

    print(hostProfile);

    return Container(
      height: 60 + 16 + 16,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: hostProfile.when(
        data: (data) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: ImageNetwork(
                    image: data.photoURL,
                    height: 60,
                    width: 60,
                    fitAndroidIos: BoxFit.cover,
                    fitWeb: BoxFitWeb.cover,
                    onPointer: true,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.displayName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data.hid,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Text("エラーです");
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

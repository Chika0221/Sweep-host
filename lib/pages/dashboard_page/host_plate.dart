// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_network/image_network.dart';

// Project imports:
import 'package:sweep_host/states/host_provider.dart';

class HostPlate extends HookConsumerWidget {
  const HostPlate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostProfile = ref.watch(hostProvider);

    return Container(
      height: 60 + 16 + 16,
      width: 300,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child:
                        (data.photoURL != "")
                            ? ImageNetwork(
                              image: data.photoURL,
                              height: 60,
                              width: 60,
                              fitWeb: BoxFitWeb.contain,
                            )
                            : Image.asset(
                              "assets/images/avatar/avatar.png",
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      data.displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data.hid,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
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

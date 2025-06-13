// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/classes/host.dart';
import 'package:sweep_host/pages/main_page.dart';
import 'package:sweep_host/states/host_provider.dart';
import 'package:sweep_host/states/login_notifier.dart';

const biwako = LatLng(35.1500, 136.1000);

class InputInfoPage extends HookConsumerWidget {
  const InputInfoPage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostId = ref.watch(loginProvider);
    final displayNameState = useState(TextEditingController());
    final homePositionState = useState<LatLng?>(null);

    return Scaffold(
      appBar: AppBar(title: const Text("ホストの情報を入力"), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: displayNameState.value,
                  decoration: const InputDecoration(labelText: "表示名"),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: biwako,
                        initialZoom: 13.0,
                        maxZoom: 20.0,
                        minZoom: 8.0,
                        initialRotation: 0,
                        onTap: (tapPosition, location) {
                          homePositionState.value = location;
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        (homePositionState.value != null)
                            ? MarkerLayer(
                              markers: [
                                Marker(
                                  point: homePositionState.value!,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    size: 30,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final data = Host(
                        displayName: displayNameState.value.text,
                        email: email,
                        homeLocation: homePositionState.value!,
                        photoURL: "https://avatar.iran.liara.run/public",
                        hid: hostId,
                      );
                      // Handle submission of host information
                      final UserDoc = await FirebaseFirestore.instance
                          .collection("host")
                          .doc(hostId);
                      await UserDoc.set(data.toJson());
                      ref.read(loginProvider.notifier).setState(hostId);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                    child: const Text("登録"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

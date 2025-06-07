// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/pages/map_page/home_position_container.dart';
import 'package:sweep_host/pages/map_page/map_page.dart';

class AddTrashboxPage extends StatefulHookConsumerWidget {
  const AddTrashboxPage({super.key});

  @override
  ConsumerState<AddTrashboxPage> createState() => _AddTrashboxPageState();
}

class _AddTrashboxPageState extends ConsumerState<AddTrashboxPage>
    with TickerProviderStateMixin {
  late AnimatedMapController animatedMapController;
  late TextEditingController nameController;
  late TextEditingController weightController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    animatedMapController = AnimatedMapController(vsync: this);
    nameController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    animatedMapController.dispose();
    nameController.dispose(); // Dispose controllers
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultWidth = MediaQuery.of(context).size.width * 0.5;
    final selectedPosition = useState<LatLng?>(null);

    final mapErrorText = useState<Widget>(SizedBox.shrink());

    return Scaffold(
      appBar: AppBar(title: Text("ゴミ箱を追加"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: defaultWidth,
            child: SingleChildScrollView(
              child: Form(
                // Wrap your Column with a Form widget
                key: _formKey, // Assign the GlobalKey
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      // Changed TextField to TextFormField
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        label: Text("名前を入力"),
                      ),
                      validator: (value) {
                        // Add validator
                        if (value == null || value.isEmpty) {
                          return '名前を入力してください';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      // Changed TextField to TextFormField
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffix: Text("kg"),
                        label: Text("最大重量"),
                      ),
                      validator: (value) {
                        // Add validator
                        if (value == null || value.isEmpty) {
                          return '最大重量を入力してください';
                        }
                        if (double.tryParse(value) == null) {
                          return '有効な数値を入力してください';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 400,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: FlutterMap(
                          mapController: animatedMapController.mapController,
                          options: MapOptions(
                            initialCenter: otsuCityOfficePosition,
                            initialZoom: 13.0,
                            maxZoom: 20.0,
                            minZoom: 8.0,
                            initialRotation: 0,
                            onTap: (tapPosition, location) {
                              selectedPosition.value = location;
                            },
                          ),

                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            ),
                            // 役所ピン
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: otsuCityOfficePosition,
                                  child: HomePositionContainer(),
                                ),
                              ],
                            ),
                            if (selectedPosition.value != null)
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    point: selectedPosition.value!,
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      size: 30,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            // 現在地ボタンと + - ボタン
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer,
                                    ),
                                    child: Column(
                                      children: [
                                        IconButton.filledTonal(
                                          onPressed:
                                              () =>
                                                  animatedMapController
                                                      .animatedZoomIn(),
                                          icon: Icon(Icons.add),
                                        ),
                                        IconButton.filledTonal(
                                          onPressed:
                                              () =>
                                                  animatedMapController
                                                      .animatedZoomOut(),
                                          icon: Icon(Icons.remove),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4), // Added spacing
                                  FloatingActionButton(
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      animatedMapController.animateTo(
                                        dest: otsuCityOfficePosition,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn,
                                        zoom: 12,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.home_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    mapErrorText.value,
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () {
                        // Validate the form
                        if (_formKey.currentState!.validate()) {
                          if (selectedPosition.value != null) {
                          } else {
                            mapErrorText.value = Text(
                              "ロケーションを選択してください",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            "登録",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/pages/dashboard_page/submit_trashbox.dart';
import 'package:sweep_host/pages/dashboard_page/trashbox_state_list_view.dart';
import 'package:sweep_host/pages/map_page/home_position_container.dart';
import 'package:sweep_host/pages/map_page/trash_maker_child.dart';
import 'package:sweep_host/states/host_provider.dart';
import 'package:sweep_host/states/post_stream_provider.dart';
import 'package:sweep_host/widgets/post_item.dart';

class MapPage extends StatefulHookConsumerWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage>
    with TickerProviderStateMixin {
  late AnimatedMapController animatedMapController;

  @override
  void initState() {
    super.initState();

    animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final postData = ref.watch(postStreamProvider);
    final hostData = ref.watch(hostProvider);
    final heatmapToggle = useState(false);
    final isOpenSideMenu = useState(false);

    return Row(
      children: [
        Expanded(
          child: hostData.when(
            data: (data) {
              return FlutterMap(
                mapController: animatedMapController.mapController,
                options: MapOptions(
                  initialCenter: data.homeLocation,
                  initialZoom: 13.0,
                  maxZoom: 20.0,
                  minZoom: 8.0,
                  initialRotation: 0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),

                  if (!heatmapToggle.value)
                    postData.when(
                      data: (data) {
                        return MarkerLayer(
                          markers: List.generate(data.length, (index) {
                            final post = data[index];
                            return Marker(
                              point: post.location,
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              rotate: true,
                              child: GestureDetector(
                                onTapDown: (details) {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) =>
                                            Dialog(child: PostItem(post: post)),
                                  );
                                },
                                child: TrashMakerChild(type: post.type),
                              ),
                            );
                          }),
                        );
                      },
                      error:
                          (error, stackTrace) =>
                              Center(child: Text(error.toString())),
                      loading: () {
                        return Positioned(
                          left: 16,
                          top: 16,
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),

                  // 役所ピン
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: data.homeLocation,
                        child: HomePositionContainer(),
                      ),
                    ],
                  ),

                  // ヒートマップ
                  if (heatmapToggle.value)
                    postData.when(
                      data: (data) {
                        final heatMapData =
                            data
                                .where((e) => e.type == PostType.trash)
                                .map((e) => WeightedLatLng(e!.location, 25))
                                .toList();

                        return Container(
                          color: Colors.black.withAlpha(100),
                          child: HeatMapLayer(
                            heatMapDataSource: InMemoryHeatMapDataSource(
                              data: heatMapData,
                            ),
                            heatMapOptions: HeatMapOptions(
                              gradient: HeatMapOptions.defaultGradient,
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return Ink(
                          color: Colors.black.withAlpha(100),
                          child: Center(child: Text("データエラー")),
                        );
                      },
                      loading: () {
                        return Ink(
                          color: Colors.black.withAlpha(100),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },
                    ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        heatmapToggle.value = !heatmapToggle.value;
                      },
                      label: Text("ヒートマップ表示"),
                    ),
                  ),

                  // サイドメニュー
                  Positioned(
                    right: 0,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                      child: IconButton.filledTonal(
                        onPressed: () {
                          isOpenSideMenu.value = !isOpenSideMenu.value;
                        },
                        icon: Icon(Icons.ads_click),
                      ),
                    ),
                  ),

                  // 現在地ボタンと + - ボタン
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Column(
                      spacing: 4,
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
                                        animatedMapController.animatedZoomIn(),
                                icon: Icon(Icons.add),
                              ),
                              IconButton.filledTonal(
                                onPressed:
                                    () =>
                                        animatedMapController.animatedZoomOut(),
                                icon: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ),

                        FloatingActionButton(
                          shape: CircleBorder(),
                          onPressed: () {
                            animatedMapController.animateTo(
                              dest: data.homeLocation,
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
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text("Error loading map data: $error"));
            },
            loading: () {
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: (isOpenSideMenu.value) ? 300 : 0,
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TrashboxStateListView(
                    onItemTap: (location) {
                      animatedMapController.animateTo(
                        dest: location,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        zoom: 15,
                      );
                    },
                  ),
                ),
                SubmitTrashboxButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

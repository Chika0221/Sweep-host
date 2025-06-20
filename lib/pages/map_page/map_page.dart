// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/pages/dashboard_page/submit_trashbox.dart';
import 'package:sweep_host/pages/dashboard_page/trashbox_state_list_view.dart';
import 'package:sweep_host/pages/map_page/home_position_container.dart';
import 'package:sweep_host/pages/map_page/trash_maker_child.dart';
import 'package:sweep_host/states/host_provider.dart';
import 'package:sweep_host/states/post_stream_provider.dart';
import 'package:sweep_host/states/trashbox_stream_provider.dart';
import 'package:sweep_host/widgets/post_item.dart';

class MapPage extends StatefulHookConsumerWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage>
    with TickerProviderStateMixin {
  late AnimatedMapController animatedMapController;

  // ルート計算
  Future<List<LatLng>> fetchRoute(List<LatLng> wayPoints) async {
    if (wayPoints.isEmpty) {
      return [];
    }

    final String points = wayPoints
        .map((point) => "${point.longitude},${point.latitude}")
        .toList()
        .join(";");

    final String url =
        "http://router.project-osrm.org/route/v1/driving/${points}?geometries=geojson";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<dynamic> coordinates =
          data['routes'][0]['geometry']['coordinates'];

      final routePoints =
          coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();

      return routePoints;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();

    animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final postData = ref.watch(postStreamProvider);
    final trashBoxData = ref.watch(trashBoxStreamProvider);
    final hostData = ref.watch(hostProvider);

    final heatmapToggle = useState(false);
    final isOpenTrashBoxList = useState(false);
    final isOpenRoutePage = useState(false);
    final routePoints = useState<List<LatLng>>([]);
    final wayPoints = useState<List<LatLng>>([
      LatLng(34.98516766981969, 136.0143951288485),
      LatLng(35.022126283391664, 135.96185499045154),
      LatLng(35.00353500276053, 135.86487627013398),
    ]);

    useEffect(() {
      Future<void> loadRoute() async {
        try {
          final fetchRoutePoints = await fetchRoute(wayPoints.value);

          routePoints.value = fetchRoutePoints;
        } catch (e) {
          debugPrint("ルート取得エラー code:$e");
          routePoints.value = [];
        }
      }

      loadRoute();
      return null;
    }, []);

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

                  if (!heatmapToggle.value) ...[
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
                    trashBoxData.when(
                      data: (data) {
                        return MarkerLayer(
                          markers: List.generate(data.length, (index) {
                            final trashBox = data[index];
                            return Marker(
                              point: trashBox.location,
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              rotate: true,
                              child: TrashMakerChild(type: PostType.trashBox),
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
                  ],

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
                                .map((e) => WeightedLatLng(e.location, 25))
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
                      label:
                          (heatmapToggle.value)
                              ? Text("ゴミ箱マップ表示")
                              : Text("ヒートマップ表示"),
                    ),
                  ),

                  if (routePoints.value.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints.value,
                          strokeWidth: 8,
                          // color: Colors.blue,
                          gradientColors: [Colors.blue, Colors.red],
                        ),
                      ],
                    ),

                  // サイドメニュー ボタンたち
                  Positioned(
                    right: 0,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 4, 8, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(24),
                        ),
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton.filledTonal(
                            onPressed: () {
                              isOpenRoutePage.value = false;
                              isOpenTrashBoxList.value =
                                  !isOpenTrashBoxList.value;
                            },
                            icon: Icon(Icons.delete_rounded),
                          ),
                          SizedBox(height: 8),
                          IconButton.filledTonal(
                            onPressed: () {
                              isOpenTrashBoxList.value = false;
                              isOpenRoutePage.value = !isOpenRoutePage.value;
                            },
                            icon: Icon(Icons.route_rounded),
                          ),
                        ],
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
                          child: Icon(
                            Icons.home_rounded,
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
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

        // サイドメニュー　SwapBox
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: (isOpenTrashBoxList.value) ? 300 : 0,
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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      isOpenTrashBoxList.value = false;
                      isOpenRoutePage.value = true;
                    },
                    child: Text("回収ルートを生成"),
                  ),
                ),
                SizedBox(height: 8),
                SubmitTrashboxButton(),
              ],
            ),
          ),
        ),

        // サイドメニュー　ルート
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: (isOpenRoutePage.value) ? 300 : 0,
          color: Theme.of(context).colorScheme.primary,
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
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text("回収ルートを生成"),
                  ),
                ),
                SizedBox(height: 8),
                SubmitTrashboxButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



/*
[
            LatLng(34.98516766981969, 136.0143951288485),
            LatLng(35.022126283391664, 135.96185499045154),
            LatLng(35.00353500276053, 135.86487627013398),
          ]

*/
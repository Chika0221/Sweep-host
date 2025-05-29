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

// 大津市役所の緯度経度 TODO: 後で消す 
const otsuCityOfficePosition = LatLng(35.01834366232745, 135.85460273093318);

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
    return FlutterMap(
      mapController: animatedMapController.mapController,
      options: MapOptions(
        initialCenter: otsuCityOfficePosition,
        initialZoom: 13.0,
        maxZoom: 20.0,
        minZoom: 8.0,
        initialRotation: 0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
    
        // postData.when(
        //   data: (data) {
        //     return MarkerLayer(
        //       markers: List.generate(data.length, (index) {
        //         final post = data[index];
        //         return Marker(
        //           point: post.location,
        //           width: 50,
        //           height: 50,
        //           alignment: Alignment.center,
        //           rotate: true,
        //           child: GestureDetector(
        //             onTapDown: (details) {
        //               showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return AlertDialog(
        //                     title: Text(post.comment),
        //                     content: Image.network(post.imagePaths[0]),
        //                   );
        //                 },
        //               );
        //             },
        //             child: TrashMakerChild(type: post.type),
        //           ),
        //         );
        //       }),
        //     );
        //   },
        //   error: (error, stackTrace) => Center(child: Text(error.toString())),
        //   loading: () {
        //     return Positioned(
        //       left: 16,
        //       top: 16,
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
    
        // 役所ピン
        MarkerLayer(
          markers: [
            Marker(
              point: otsuCityOfficePosition,
              child: HomePositionContainer(),
            ),
          ],
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
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Column(
                  children: [
                    IconButton.filledTonal(
                      onPressed: () => animatedMapController.animatedZoomIn(),
                      icon: Icon(Icons.add),
                    ),
                    IconButton.filledTonal(
                      onPressed:
                          () => animatedMapController.animatedZoomOut(),
                      icon: Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
    
              FloatingActionButton(
                shape: CircleBorder(),
                onPressed: () {
                  animatedMapController.animateTo(
                    dest: otsuCityOfficePosition,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                child: const Icon(Icons.home_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

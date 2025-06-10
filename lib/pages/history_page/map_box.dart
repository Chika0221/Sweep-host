// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Project imports:
import 'package:sweep_host/classes/post.dart';
import 'package:sweep_host/pages/map_page/trash_maker_child.dart';

class MapBox extends HookConsumerWidget {
  const MapBox({super.key, required this.location, required this.type});

  final LatLng location;
  final PostType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const zoom = 14.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: FlutterMap(
        options: MapOptions(
          initialCenter: location,
          initialZoom: zoom,
          maxZoom: zoom,
          minZoom: zoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(point: location, child: TrashMakerChild(type: type)),
            ],
          ),
        ],
      ),
    );
  }
}

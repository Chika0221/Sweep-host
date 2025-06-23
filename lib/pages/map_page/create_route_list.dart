



// class CreateRouteList extends HookConsumerWidget {
//   const CreateRouteList({super.key});


//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     return ListView.builder(
//       itemCount: wayPoints.value.length,
//       itemBuilder: (context, index) {
//         if (index == 0) {
//           return Container(
//             height: 64,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             child: Center(
//               child: Text(
//                 "スタート",
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.onSecondary,
//                 ),
//               ),
//             ),
//           );
//         } else if (wayPoints.value.length - 1 == index) {
//           return Container(
//             height: 64,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             child: Center(
//               child: Text(
//                 "ゴール",
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.onSecondary,
//                 ),
//               ),
//             ),
//           );
//         }
//         return Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: TimelineTile(
//             indicatorStyle: IndicatorStyle(
//               width: 12,
//               indicator: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//               ),
//             ),
//             beforeLineStyle: LineStyle(
//               thickness: 4,
//               color: Theme.of(context).colorScheme.onSurface,
//             ),
//             alignment: TimelineAlign.start,
//             endChild: Padding(
//               padding: EdgeInsets.fromLTRB(4, 4, 0, 4),
//               child: TrashboxStateListViewItem(
//                 trashBox: wayPoints.value[index],
//                 onTap: (location) {},
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

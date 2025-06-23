part of 'dashboard_page.dart';

class ChatList extends HookConsumerWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: 100,
            itemBuilder: (context, index) {
              return TalkBubble(isHost: index % 2 == 0, text: index.toString());
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 4);
            },
          ),
        ),
        TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ],
    );
  }
}

class TalkBubble extends HookConsumerWidget {
  const TalkBubble({super.key, required this.isHost, required this.text});

  final bool isHost;
  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        if (isHost) Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color:
                (isHost)
                    ? Theme.of(context).colorScheme.tertiaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomRight: (isHost) ? Radius.zero : Radius.circular(8),
              bottomLeft: (isHost) ? Radius.circular(8) : Radius.zero,
            ),
          ),
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
        if (!isHost) Spacer(),
      ],
    );
  }
}

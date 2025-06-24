part of 'dashboard_page.dart';

const List<Map<String, dynamic>> chatstr = [
  {"isHost": false, "text": "こんにちは。公園のゴミ箱から\nゴミが溢れてしまっています。"},
  {"isHost": true, "text": "ご連絡ありがとうございます。\nご不便をおかけし\n申し訳ありません。"},
  {"isHost": true, "text": "すぐに清掃員を向かわせます。\n場所はどのあたりでしょうか？"},
  {"isHost": false, "text": "東口のトイレの隣\nにあるゴミ箱です。"},
  {"isHost": true, "text": "承知いたしました。\n対応いたします。"},
  {"isHost": null, "text": ""},
  {"isHost": false, "text": "先程のゴミの件、\n対応いただけたでしょうか？"},
  {"isHost": true, "text": "はい、先ほど清掃が\n完了いたしました。\nご協力ありがとうございました。"},
  {"isHost": false, "text": "素早い対応、\nありがとうございました！"},
];

class ChatList extends HookConsumerWidget {
  const ChatList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: chatstr.length,
            itemBuilder: (context, index) {
              if (chatstr[index]["isHost"] == null) {
                return SizedBox(height: 16);
              } else {
                return TalkBubble(
                  isHost: chatstr[index]["isHost"],
                  text: chatstr[index]["text"],
                );
              }
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
      mainAxisAlignment:
          isHost ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color:
                isHost
                    ? Theme.of(context).colorScheme.tertiaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isHost ? 16 : 0),
              bottomRight: Radius.circular(isHost ? 0 : 16),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
                  isHost
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}

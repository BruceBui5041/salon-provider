import '../../../config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to initialize the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ChatProvider>(context, listen: false);
      provider.onReady(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          ChatAppBarLayout(onSelected: (index) {
            if (index == 1) {
              value.onClearChat(context, this);
            } else {
              value.onTapPhone();
            }
          }),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (value.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!value.isLoading && value.chatList.isEmpty)
                  Center(
                    child: Text(
                      "No messages yet. Start a conversation!",
                      style: appCss.dmDenseMedium14.textColor(
                        appColor(context).appTheme.lightText,
                      ),
                    ),
                  ),
                if (!value.isLoading && value.chatList.isNotEmpty)
                  Text("Today 12:15 AM",
                          style: appCss.dmDenseMedium14
                              .textColor(appColor(context).appTheme.lightText))
                      .paddingOnly(bottom: Insets.i20),
                if (!value.isLoading && value.chatList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      controller: value.scrollController,
                      itemCount: value.chatList.length,
                      itemBuilder: (context, index) {
                        final message = value.chatList[index];
                        final isSentByMe = value.isSentByMe(message);

                        return ChatLayout(
                            title: message.content, isSentByMe: isSentByMe);
                      },
                    ),
                  ),
              ],
            ),
          ),
          Row(children: [
            // Text Field
            Expanded(
                child: TextFieldCommon(
                    focusNode: value.focus,
                    controller: value.controller,
                    hintText: appFonts.writeHere,
                    prefixIcon: eSvgAssets.emoji,
                    suffixIcon: SvgPicture.asset(eSvgAssets.microphone,
                        height: Sizes.s15,
                        width: Sizes.s15,
                        fit: BoxFit.scaleDown))),
            const HSpace(Sizes.s8),
            // Send button
            SizedBox(
                    child:
                        SvgPicture.asset(eSvgAssets.send).paddingAll(Insets.i8))
                .decorated(
                    color: appColor(context).appTheme.primary,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r6)))
                .inkWell(onTap: () => value.setMessage())
          ])
              .paddingOnly(
                  right: rtl(context) ? 0 : Insets.i5,
                  left: rtl(context) ? Insets.i5 : 0)
              .boxBorderExtension(context, isShadow: true, radius: 0)
        ]),
      );
    });
  }
}

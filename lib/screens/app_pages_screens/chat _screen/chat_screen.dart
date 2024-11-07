import '../../../config.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 100), () => value.onReady()),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
              body: Column(children: [
             ChatAppBarLayout(
                 onSelected: (index){
                 if(index == 1){
                   value.onClearChat(context, this);
                 } else {
                   value.onTapPhone();
                 }
            }),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Today 12:15 AM",style: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.lightText)).paddingOnly(bottom: Insets.i20),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        controller: value.scrollController,
                        itemCount: value.chatList.length,
                        itemBuilder: (context, index) {
                          if (index == value.chatList.length) {
                            return Container(height: Sizes.s20);
                          }

                          if (value.chatList[index].type == "source") {
                            return ChatLayout(
                                title: value.chatList[index].message,
                                isSentByMe: true);
                          } else {
                            return ChatLayout(
                                title: value.chatList[index].message,
                                isSentByMe: false);
                          }
                        }).alignment(Alignment.bottomCenter),
                  ],
                )),
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
                      child: SvgPicture.asset(eSvgAssets.send)
                          .paddingAll(Insets.i8))
                  .decorated(
                      color: appColor(context).appTheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppRadius.r6)))
                  .inkWell(onTap: () => value.setMessage())
            ])
                .paddingOnly(right: rtl(context) ? 0 : Insets.i5, left: rtl(context) ? Insets.i5 : 0)
                .boxBorderExtension(context, isShadow: true,radius: 0)

          ])));
    });
  }
}

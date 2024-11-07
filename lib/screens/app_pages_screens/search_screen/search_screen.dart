import '../../../config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: ()=> Future.delayed(const Duration(milliseconds: 20),() => value.onReady()),
        child: Scaffold(
            appBar: AppBarCommon(title: appFonts.search),
            body: /*EmptyLayout(
              title: appFonts.noMatching,
              subtitle: appFonts.attemptYourSearch,
              isButton: true,
              buttonText: appFonts.searchAgain,
              bTap: (){},
              widget: Image.asset(eImageAssets.noSearch, height: Sizes.s340))*/
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SearchTextFieldCommon(
                      onChanged: (query)=> value.onSearch(query),
                      focusNode: value.searchFocus,
                        controller: value.searchCtrl),
                    const VSpace(Sizes.s25),
                       /* if(value.searchList.isEmpty)
                          EmptyLayout(
                              title: appFonts.youHaveNotSearch,
                              subtitle: appFonts.startSearching,
                              isButton: false,
                              widget: Image.asset(eImageAssets.noSearch, height: Sizes.s340)).paddingOnly(top: Insets.i50),*/

                        value.searchList.isNotEmpty ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language(context, appFonts.recentSearch),
                            style: appCss.dmDenseMedium14
                                .textColor(appColor(context).appTheme.lightText)),
                        const VSpace(Sizes.s15),
                        ...value.searchList
                            .asMap()
                            .entries
                            .map((e) => FeaturedServicesLayout(data: e.value))
                            .toList()
                      ]
                    ) : EmptyLayout(
                            title: appFonts.noMatching,
                            subtitle: appFonts.attemptYourSearch,
                            isButton: false,
                            widget: Image.asset(eImageAssets.noSearch, height: Sizes.s340)).paddingOnly(top: Insets.i50)
                  ]).paddingSymmetric(horizontal: Insets.i20)
                ))
      );
    });
  }
}

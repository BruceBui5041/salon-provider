import '../../../../config.dart';

class LanguageDropDownLayout extends StatelessWidget {
  const LanguageDropDownLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, langProvider, child) {
      return SizedBox(
          width: langProvider.currentLanguage == "vietnamese"
              ? Sizes.s150
              : Sizes.s120,
          child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                  child: DropdownButton(
                      value: langProvider.currentLanguage.toString(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppRadius.r8)),
                      style: appCss.dmDenseMedium16
                          .textColor(appColor(context).appTheme.lightText),
                      icon: SvgPicture.asset(eSvgAssets.dropDown,
                          colorFilter: ColorFilter.mode(
                              appColor(context).appTheme.darkText,
                              BlendMode.srcIn)),
                      isDense: true,
                      isExpanded: true,
                      hint: Text(langProvider.currentLanguage
                          // .substring(0, 2)
                          .toString()),
                      selectedItemBuilder: (context) {
                        int index = appArray.languageList.indexWhere(
                            (element) =>
                                element['title'] ==
                                langProvider.currentLanguage);
                        return List.generate(appArray.languageList.length, (i) {
                          return i == index
                              ? Row(children: [
                                  Image.asset(
                                      appArray.languageList[index]['icon']
                                          .toString(),
                                      width: Sizes.s30,
                                      height: Sizes.s30),
                                  const HSpace(Sizes.s5),
                                  Text(
                                      language(
                                              context,
                                              appArray.languageList[index]
                                                      ["title"]!
                                                  .toString())
                                          // .substring(0, 2)
                                          .toUpperCase(),
                                      style: appCss.dmDenseMedium14.textColor(
                                          appColor(context).appTheme.darkText),
                                      overflow: TextOverflow.ellipsis)
                                ])
                              : Container();
                        });
                      },
                      items: appArray.languageList.asMap().entries.map((e) {
                        return DropdownMenuItem(
                            value: e.value["title"],
                            child: Row(children: [
                              Image.asset(e.value['icon'].toString(),
                                  width: Sizes.s30, height: Sizes.s30),
                              const HSpace(Sizes.s5),
                              SizedBox(
                                child: Text(
                                  language(
                                      context, e.value["title"]!.toString()),
                                  style: appCss.dmDenseMedium14.textColor(
                                      appColor(context).appTheme.lightText),
                                ),
                              )
                            ]),
                            onTap: () => langProvider.onBoardLanguageChange(
                                e.value["title"].toString()));
                      }).toList(),
                      onChanged: (val) async {
                        langProvider.currentLanguage = val.toString();
                        langProvider.onBoardLanguageChange(
                            langProvider.currentLanguage);
                      })))).paddingAll(Insets.i7).decorated(
          color: appColor(context).appTheme.whiteBg,
          borderRadius: BorderRadius.circular(AppRadius.r6),
          boxShadow: [
            BoxShadow(
                color: appColor(context).appTheme.fieldCardBg,
                blurRadius: AppRadius.r10,
                spreadRadius: AppRadius.r5),
          ],
          border: Border.all(color: appColor(context).appTheme.fieldCardBg));
    });
  }
}

import '../../../../config.dart';

class TextFieldLayout extends StatelessWidget {
  final ProfileDetailProvider? value;

  const TextFieldLayout({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ContainerWithTextLayout(title: appFonts.firstName),
      const VSpace(Sizes.s8),
      TextFieldCommon(
              controller: value!.txtFirstName,
              hintText: appFonts.enterFirstName,
              focusNode: value!.firstNameFocus,
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value!.firstNameFocus, value!.lastNameFocus),
              prefixIcon: eSvgAssets.user,
              validator: (value) => validation.nameValidation(context, value))
          .paddingSymmetric(horizontal: Insets.i20),
      const VSpace(Sizes.s15),
      ContainerWithTextLayout(title: appFonts.lastName),
      const VSpace(Sizes.s8),
      TextFieldCommon(
              controller: value!.txtLastName,
              hintText: appFonts.enterLastName,
              focusNode: value!.lastNameFocus,
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value!.lastNameFocus, value!.emailFocus),
              prefixIcon: eSvgAssets.user,
              validator: (value) => validation.nameValidation(context, value))
          .paddingSymmetric(horizontal: Insets.i20),
      const VSpace(Sizes.s15),
      ContainerWithTextLayout(title: language(context, appFonts.email)),
      const VSpace(Sizes.s8),
      TextFieldCommon(
              controller: value!.txtEmail,
              hintText: language(context, appFonts.enterEmail),
              focusNode: value!.emailFocus,
              onFieldSubmitted: (values) => validation.fieldFocusChange(
                  context, value!.emailFocus, value!.phoneFocus),
              prefixIcon: eSvgAssets.email,
              validator: (value) => validation.emailValidation(context, value))
          .paddingSymmetric(horizontal: Insets.i20),
      const VSpace(Sizes.s15),
      ContainerWithTextLayout(title: language(context, appFonts.phoneNo)),
      const VSpace(Sizes.s10),
      RegisterWidgetClass().phoneTextBox(
          context, value!.txtPhone, value!.phoneFocus,
          onChanged: (CountryCodeCustom? code) => value!.changeDialCode(code!),
          onFieldSubmitted: (values) => validation.fieldFocusChange(
              context, value!.phoneFocus, value!.phoneFocus))
    ]);
  }
}

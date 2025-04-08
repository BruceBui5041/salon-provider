import 'dart:io';
import '../config.dart';

class ProfilePicCommon extends StatelessWidget {
  final bool? isProfile;

  final String? imageUrl;
  final XFile? image;

  const ProfilePicCommon(
      {super.key, this.imageUrl, this.image, this.isProfile});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          height: Sizes.s88,
          width: Sizes.s88,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: image != null
                  ? DecorationImage(
                      image: FileImage(File(image!.path)), fit: BoxFit.cover)
                  : imageUrl != null && imageUrl!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(imageUrl!), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(eImageAssets.as2),
                          fit: BoxFit.cover),
              border: Border.all(
                  color: isProfile == true
                      ? appColor(context).appTheme.whiteBg.withOpacity(0.75)
                      : appColor(context).appTheme.trans,
                  width: isProfile == true ? 4 : 2,
                  style: BorderStyle.solid))),
      Container(
          height: isProfile == true ? Sizes.s82 : Sizes.s85,
          width: isProfile == true ? Sizes.s82 : Sizes.s85,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: appColor(context).appTheme.whiteBg,
                  width: isProfile == true ? 2 : 1,
                  style: BorderStyle.solid)))
    ]);
  }
}

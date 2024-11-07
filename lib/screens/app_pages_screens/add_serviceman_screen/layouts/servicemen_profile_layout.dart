import 'dart:io';

import '../../../../config.dart';

class ServicemenProfileLayout extends StatelessWidget {
  final Widget? child;
  final bool? isFilePath;
  final Color? color;
  const ServicemenProfileLayout({super.key,this.child,this.isFilePath = false,this.color });

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddServicemenProvider>(context);
    return Container(
        alignment: Alignment.center,
        height: Sizes.s90,
        width: Sizes.s90,
        decoration: BoxDecoration(
          color: color ?? appColor(context).appTheme.stroke,
            border: Border.all(
                color:
                appColor(context).appTheme.whiteColor,
                width: 4),
            shape: BoxShape.circle,
            image: isFilePath == true ? DecorationImage(
                fit: BoxFit.cover,
                image:  FileImage(
                    File(value.profileFile!.path))) : null ),
           child: child,
    )
        .paddingOnly(top: Insets.i12)
        .inkWell(onTap: () => value.onImagePick(context, true));
  }
}

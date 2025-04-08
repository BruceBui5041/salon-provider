import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_provider/common/theme/app_css.dart';

class DropDownCommon<T> extends StatelessWidget {
  final String? icon, hintText;
  final T? val;
  final List<T>? list;
  final ValueChanged<T?>? onChanged;
  final bool? isIcon, isField, isBig, isListIcon, isOnlyText;
  final Widget Function(T item) itemLabel;
  final String Function(T item)? itemImage;
  final bool? isShowBackground;

  const DropDownCommon({
    super.key,
    this.icon,
    this.hintText,
    this.val,
    this.onChanged,
    required this.itemLabel,
    this.itemImage,
    this.isField = false,
    this.isIcon = false,
    this.isBig = false,
    this.list,
    this.isListIcon = false,
    this.isOnlyText = false,
    this.isShowBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: Insets.i15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            child: DropdownButtonFormField<T>(
              hint: Text(hintText ?? ""),
              decoration: InputDecoration(
                prefixIcon: isIcon == true && icon != null
                    ? SvgPicture.asset(icon!, fit: BoxFit.scaleDown)
                    : null,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              value: val,
              borderRadius: BorderRadius.circular(8),
              icon: Icon(Icons.arrow_drop_down),
              isDense: true,
              isExpanded: true,
              items: list?.map((item) {
                return DropdownMenuItem<T>(
                  key: Key(item.toString()),
                  value: item,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isShowBackground == true
                          ? Colors.grey.shade300
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        // if (isListIcon == true && itemImage != null)
                        //   SizedBox(
                        //     height: 13,
                        //     width: 13,
                        //     child: Image.network(itemImage!(item),
                        //         fit: BoxFit.scaleDown),
                        //   ),
                        // if (isListIcon == true) SizedBox(width: 12),
                        // Text(itemLabel(item))
                        itemLabel(item)
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}

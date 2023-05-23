import 'package:flutter/material.dart';
import 'package:laundry_delivery/utils/const/consts.dart';

import '../colors.dart';

class InputFieldCustom extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? hintColor;
final bool autoValidate;
final Widget? suffix;
final bool? isVisibilty;
final TextInputType? inputType;
final int? maxLines;
final double? size;
final double? spacing;
final double? vertPad;
final int? minLines;
final String? hint;
final String? Function(String?)? validator;
final bool? readOnly;
final int? maxLength;
final double? labelSize;
final bool? isBold;
final VoidCallback? onTap;
final ValueChanged? onChange;

  InputFieldCustom(
  {required this.label,
  this.controller,
  this.hintColor,
  this.borderColor,
  this.labelColor,
   this.suffix,
   this.isVisibilty,
  this.inputType,
  this.maxLines,
  this.size,
  this.spacing,
  this.minLines,
  this.vertPad,
  this.hint,
  this.validator,
  this.readOnly,
  this.maxLength,
  this.labelSize,
  this.isBold = false,
  this.autoValidate = false,
  this.onTap,
  this.onChange});
  @override
  Widget build(BuildContext context) {

    var h=height/500;
    var b=width/500;
    var outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor??borderGreyColor,
        width: 1.5
      ),
      borderRadius: BorderRadius.circular(6),

    );

    var outlineInputErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: redColor,
          width: 1.5
      ),
      borderRadius: BorderRadius.circular(6),

    );
    return Padding(
      padding:EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                fontWeight: isBold! ? FontWeight.w500 : FontWeight.w400,
                fontSize: labelSize ??  14,

                color: labelColor??blackColor,
              ),
            ),
          if (label != null) heightBox(10),
          TextFormField(


            onChanged: onChange,
            onTap: onTap,
            cursorColor: secondaryColor,
            key: key,
            readOnly: readOnly ?? false,
            validator: validator ??
                    (val) {
                  return null;
                },

            style: TextStyle(

              // height: 1.5,
              fontSize: size ?? 15,
              fontWeight: FontWeight.normal,
              letterSpacing: spacing ?? 0,
            ),
            maxLength: maxLength ?? null,
            controller: controller,
            keyboardType: inputType ?? TextInputType.text,
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,

            decoration: InputDecoration(

              isDense: true,
              counterText: '',
              // prefixIcon: suffix != null
              //     ? Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     widthBox(15),
              //     suffix!,
              //   ],
              // )
              //     : null,
              suffixIcon: suffix != null
    ? Row(
    mainAxisSize: MainAxisSize.min,
    children: [
    widthBox(15),
    suffix!,
    ],
    )
        : null,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: size ?? 12,
                fontWeight: FontWeight.w400,
                color: hintColor??borderGreyColor,
                letterSpacing: spacing ?? 0,
              ),
              errorStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: redColor,
                letterSpacing: spacing ?? 0,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: vertPad ?? 12,
              ),
              focusedBorder:
              outlineInputBorder,
              focusedErrorBorder:outlineInputErrorBorder,
              border: outlineInputBorder,
              errorBorder: outlineInputErrorBorder,
              enabledBorder: outlineInputBorder,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:laundry_delivery/utils/const/consts.dart';

import '../colors.dart';

class InputFieldCustom extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final TextEditingController? controller;
  final InputDecoration? decoration;
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
  { this.label,
  this.controller,
    this.decoration,
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



class AppTextFieldPassword extends StatefulWidget {
  AppTextFieldPassword({
    @required this.label,
    @required this.controller,
    this.inputType,
    this.size,
    this.spacing,
    this.vertPad,
    this.hint,
    this.validator,
    this.error,
    this.isMisMatch,
  });

  final String? label;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final double? size;
  final double? spacing;
  final double? vertPad;
  final String? hint;
  final bool? error;
  final String? Function(String?)? validator;
  bool? isMisMatch;

  @override
  _AppTextFieldPasswordState createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool isVisibilty = false;
  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height:10),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: widget.vertPad ?? 0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.error! ? secondaryColor : secondaryColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorColor: secondaryColor,
                  validator: widget.validator ??
                          (val) {
                        return null;
                      },
                  style: TextStyle(
                    fontSize: widget.size ?? 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: widget.spacing ?? 0,
                  ),
                  controller: widget.controller,
                  obscureText: !isVisibilty,
                  obscuringCharacter: "*",
                  keyboardType: widget.inputType ?? TextInputType.text,
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      fontSize: widget.size ??  14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8),
                      letterSpacing: widget.spacing ?? 0,
                    ),
                    errorStyle: TextStyle(
                      fontSize: 0,
                      height: 0,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  isVisibilty = !isVisibilty;
                  setState(() {});
                },
                child: Icon(
                  isVisibilty ? Icons.visibility : Icons.visibility_off,
                  size: 22,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height:10),
        widget.error!
            ? widget.isMisMatch!
            ? Text(
          "     " + "* Passwords don't match",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: secondaryColor,
          ),
        )
            : Text(
          "     " + 'Field is Empty',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: secondaryColor,
          ),
        )
            : SizedBox(height:10),
      ],
    );
  }
}
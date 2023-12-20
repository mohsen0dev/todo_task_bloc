import 'package:flutter/material.dart';

Widget myTextfild({
  required var wi,
  required TextEditingController txtControlr,
  TextInputType? textInputType = TextInputType.text,
  TextInputAction? textInputAction = TextInputAction.next,
  int? maxLength,
  Color slctBrdrColr = Colors.black,
  Color unSlctBrdrColr = Colors.black,
  Color? cursorColor,
  double rdusCircul = 13,
  Text? lablText,
  Icon? icon,
  String? validator = 'اطلاعات مورد نظر را وارد کنید',
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: wi * 0.01),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: txtControlr,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        cursorColor: cursorColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == '') return validator;
          return null;
        },
        decoration: InputDecoration(
          label: lablText,
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rdusCircul),
            borderSide: BorderSide(color: unSlctBrdrColr),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rdusCircul),
            borderSide: BorderSide(color: slctBrdrColr),
          ),
        ),
      ),
    ),
  );
}

// ignore_for_file: sized_box_for_whitespace, file_names, deprecated_member_use, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFields extends StatelessWidget {
  final String headerText;
  final String hintText;
  final bool hasHeader;
  final TextEditingController? textController;
  final bool? isEditable;
  final Widget? suffixIcon;
  final Function? onChange;
  final TextInputType? inputType;

  const InputFields(
      {Key? key,
      required this.headerText,
      required this.hintText,
      required this.hasHeader,
      this.textController,
      this.isEditable,
      this.suffixIcon,
      this.inputType,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(),
          child: Text(
            headerText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'sfpro',
            ),
          ),
        ),
        TextField(
          cursorHeight: 20,
          controller: textController,
          enabled: isEditable,
          keyboardType: inputType ?? TextInputType.text,
          inputFormatters: [
            inputType == null
                ? LengthLimitingTextInputFormatter(
                    headerText.contains('Name') ? 18 : 50)
                : FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,10}'))
          ],
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'sfpro',
            ),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'sfpro',
                 ),
              filled: true,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black, width: 0.1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black, width: 0.1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black, width: 0.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: suffixIcon ?? const SizedBox()),
          onChanged: (value) {
            onChange!.call(value);
          },
        ),
      ],
    );
  }
}




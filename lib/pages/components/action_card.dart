import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key,
      this.leadingIcon,
      required this.title,
      this.backgroundColor,
      this.foregroundColor,
      this.hasBorder = true,
      this.trailingIcon,
      this.controller,
      this.onChanged,
      this.isTextfield = false});
  final Widget? leadingIcon;
  final String title;
  final Widget? trailingIcon;
  final bool isTextfield;
  final bool hasBorder;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          if (leadingIcon != null) leadingIcon!,
          const SizedBox(width: 10),
          isTextfield
              ? SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: onChanged,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: title,
                    ),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: foregroundColor ?? Colors.black,
                  ),
                ),
          const SizedBox(
            width: 10,
          ),
          if (trailingIcon != null) trailingIcon!,
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/res/dimen.dart';

import '../theme/app_color.dart';
import '../theme/app_style.dart';

class SearchBarWidget extends StatefulWidget {
  final String? placeHolder;
  final TextEditingController? editingController;
  final TextInputType textInputType;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final String? iconName;
  final TextInputAction textInputAction;
  final bool isEditable;
  final String? prefixText;
  final int? maxLength;
  final String? errorText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconClick;
  final double? marginTop;
  final double? marginBottom;
  final String? Function(String?)? validation;
  final String? Function(String)? onSearched;
  final String? Function(String)? onChange;

  // final SearchCubit? searchCubit;

  const SearchBarWidget(
      {
        Key? key,
        required this.placeHolder,
        this.editingController,
        required this.textInputType,
        required this.obscureText,
        required this.enableSuggestions,
        required this.autocorrect,
        this.iconName,
        required this.textInputAction,
        required this.isEditable,
        this.prefixText,
        this.maxLength,
        this.errorText,
        this.suffixIcon,
        this.onSuffixIconClick,
        this.marginTop,
        this.marginBottom,
        this.validation,
        this.onSearched,
        this.onChange,

        // this.searchCubit,

      })
      : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration (
          color: AppColor.greyColor15,
          borderRadius: BorderRadius.all(Radius.circular(Dimen.dimen_5))
      ),
      child: TextField(
        controller: widget.editingController,
        style: AppStyle.textStyle14(color: AppColor.greyColor8),
        decoration: InputDecoration(
          hintText: widget.placeHolder,
          hintStyle: AppStyle.textStyle14(fontWeight: FontWeight.w500),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search,
              color: AppColor.greyColor6,
            ),
            onPressed: () {
              widget.onSearched!(widget.editingController!.text);
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
              left: Dimen.dimen_12,
              top: Dimen.dimen_12
          ),
        ),
        onChanged: widget.onChange,


      ),
    );
  }

}


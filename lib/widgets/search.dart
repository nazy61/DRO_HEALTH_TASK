import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Function? onChanged;

  const SearchBox({
    Key? key,
    this.controller,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.white,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLines: 1,
              onChanged: (value) => onChanged!(value),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  left: 15,
                  bottom: 11,
                  top: 11,
                  right: 15,
                ),
                hintText: hint,
                hintStyle: textStyle15WhiteBold,
              ),
              style: textStyle15White,
            ),
          ),
        ],
      ),
    );
  }
}

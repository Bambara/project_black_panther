import 'package:flutter/material.dart';

import '../core/app_export.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool enableValidate;
  final TextEditingController txtCtrl;
  final double fontSize;
  final double heightFactor;
  final double widthFactor;
  final TextInputType inputType;
  final List items;
  final Function(String) onItemTap;

  const SearchTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.enableValidate,
    required this.txtCtrl,
    required this.fontSize,
    required this.heightFactor,
    required this.widthFactor,
    required this.inputType,
    required this.items,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return SizedBox(
      width: screenWidth * widthFactor,
      height: screenHeight * heightFactor,
      child: TextField(
        style: TextStyle(fontSize: screenWidth * fontSize),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        controller: txtCtrl,
        autocorrect: true,
        // decoration: InputDecoration(
        //   border: InputBorder.none,
        //   hintText: hintText,
        //   // labelText: widget.hintText,
        // ),

        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate(items: items, txtCtrl: txtCtrl, onItemTap: onItemTap));
              },
              icon: Icon(
                Icons.search_rounded,
                color: themeData.textTheme.bodySmall!.color!.withAlpha(200),
              )),
          labelText: labelText,
          hintText: hintText,
          fillColor: themeData.colorScheme.secondary.withAlpha(25),
          constraints: const BoxConstraints.expand(),
          filled: true,
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius))),
          focusedBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: enableValidate
                ? txtCtrl.text.isEmpty
                    ? BorderSide(color: themeData.colorScheme.error, width: 2)
                    : BorderSide.none
                : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List items;
  final TextEditingController txtCtrl;
  final Function(String) onItemTap;

  CustomSearchDelegate({required this.items, required this.txtCtrl, required this.onItemTap});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var element in items) {
      if (element.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        // var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            txtCtrl.text = matchQuery[index].toString();
            onItemTap(txtCtrl.text.toString());
            close(context, null);
          },
          child: ListTile(
            title: Text(matchQuery[index]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var element in items) {
      if (element.toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        // var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            txtCtrl.text = matchQuery[index].toString();
            onItemTap(txtCtrl.text.toString());
            close(context, null);
          },
          child: ListTile(
            title: Text(matchQuery[index]),
          ),
        );
      },
    );
  }
}

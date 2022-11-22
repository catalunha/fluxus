import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownWithSearch extends StatefulWidget {
  final String hint;
  final Function(String?)? onChanged;
  const DropDownWithSearch(
      {Key? key, required this.onChanged, required this.hint})
      : super(key: key);

  @override
  State<DropDownWithSearch> createState() => _DropDownWithSearchState();
}

class _DropDownWithSearchState extends State<DropDownWithSearch> {
  TextEditingController searchController = TextEditingController();
  final List<String> _list = [
    "Follow",
    "lakshydeep-14",
    "on",
    "Github",
    "Medium",
    "LinkedIn"
  ];
  @override
  Widget build(BuildContext context) {
    var mainColor = Colors.white;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
      decoration: BoxDecoration(
          color: mainColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            " Select",
            // style: context.text.headline4!.copyWith(
            //     color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 1,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                hint: Text(
                  widget.hint,
                  // style: context.text.headline5!.copyWith(
                  //   fontWeight: FontWeight.w400,
                  //   color: Colors.black.withOpacity(0.8),
                  // ),
                ),
                onChanged: widget.onChanged,
                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  ..._list.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                ],
                //isExpanded: false,

                buttonElevation: 0,
                searchController: searchController,
                dropdownElevation: 0,
                buttonWidth: 100, //context.deviceWidth,
                dropdownMaxHeight: 250,
                scrollbarThickness: 5.0,
                searchMatchFn: (a, searchValue) {
                  return a.value.toString().toLowerCase().contains(searchValue);
                },
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    searchController.clear();
                  }
                },
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(fontSize: 12, color: mainColor),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: mainColor,
                                style: BorderStyle.solid,
                                width: 1.5)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: mainColor,
                                width: 1.5,
                                style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide(
                                color: mainColor,
                                style: BorderStyle.solid,
                                width: 1.5))),
                  ),
                ),
                dropdownDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.5)),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                buttonDecoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
                buttonHeight: 56,
                itemHeight: 40,
                icon: const RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.chevron_left)),
                iconOnClick: const RotatedBox(
                    quarterTurns: 1, child: Icon(Icons.chevron_left)),
                // style: context.text.headline4!.copyWith(
                //     color: Colors.black.withOpacity(0.5),
                //     fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

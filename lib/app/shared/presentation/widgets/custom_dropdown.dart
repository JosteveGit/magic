import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class CustomDropDownItem<T> {
  final T value;
  final String text;
  final Widget? prefix;

  const CustomDropDownItem({
    this.prefix,
    required this.value,
    required this.text,
  });

  @override
  String toString() {
    return "CustomDropDownItem(value: $value, text: $text)";
  }
}

class CustomDropDown<T> extends ConsumerStatefulWidget {
  final String header;
  final List<CustomDropDownItem<T>> items;
  final Function(T value) onSelected;
  final Widget? suffix;
  final T value;
  final double? maxHeight;
  final double minHeight;

  final bool defaultEmpty;
  final bool searchable;
  final bool headerLess;
  final bool required;
  final VoidCallback? onTap;

  const CustomDropDown({
    super.key,
    required this.header,
    required this.items,
    required this.onSelected,
    required this.value,
    this.searchable = false,
    this.suffix,
    this.maxHeight,
    this.defaultEmpty = false,
    this.headerLess = false,
    this.minHeight = 70,
    this.required = false,
    this.onTap,
  });

  @override
  ConsumerState<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends ConsumerState<CustomDropDown<T>> {
  ScrollController controller = ScrollController();

  bool expanded = false;
  late List<CustomDropDownItem<T>> items;
  late CustomDropDownItem<T> selectedItem;

  FocusNode focusNode = FocusNode();
  List<CustomDropDownItem<T>>? fList;
  bool emptyList = false;

  void filterList(String query) {
    if (query.isEmpty) {
      setState(() {
        fList = null;
      });
      return;
    }
    List<CustomDropDownItem<T>> newItems =
        List.generate(items.length, (index) => items[index])
          ..where((element) => element.value != selectedItem.value);
    setState(() {
      fList = newItems
          .where((e) => e.text.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  initState() {
    super.initState();
    items = widget.items;
    emptyList = widget.defaultEmpty;
  }

  @override
  Widget build(BuildContext context) {
    setSelectedItem(widget.value);
    final colors = ref.watch(appThemeProvider).colors;
    return IgnorePointer(
      ignoring: emptyList,
      child: GestureDetector(
        onTap: () {
          setState(() {
            expanded = !expanded;
            if (!expanded) {
              FocusScope.of(context).unfocus();
            }
            controller.animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
            );
          });
          if (expanded) {
            widget.onTap?.call();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.headerLess) ...[
              Row(
                children: [
                  Text(
                    widget.header,
                    style: TextStyle(
                      color: colors.alwaysWhite,
                      fontSize: 14,
                    ),
                  ),
                  if (widget.required) ...[
                    const SizedBox(width: 5),
                    const Text(
                      "*",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
            ],
            Container(
              padding: EdgeInsets.zero,
              child: AnimatedContainer(
                height: calculateHeight(),
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                decoration: BoxDecoration(
                  // color: colors.secondary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors.secondary,
                    width: 1,
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: controller,
                  physics: widget.maxHeight != null
                      ? (expanded
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics())
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            selectedItem.prefix ?? const SizedBox(),
                            Expanded(
                              child: Text(
                                selectedItem.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colors.alwaysWhite,
                                ),
                              ),
                            ),
                            widget.suffix ??
                                RotatedBox(
                                  quarterTurns: expanded ? 2 : 0,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: colors.alwaysWhite,
                                  ),
                                )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Divider(
                          color: colors.secondary,
                        ),
                        if (widget.searchable)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);
                                },
                                child: Container(
                                  color: colors.transparent,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          focusNode: focusNode,
                                          onChanged: (v) {
                                            filterList(v);
                                          },
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: colors.alwaysWhite,
                                          ),
                                          decoration: InputDecoration.collapsed(
                                            hintText: "Search",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: colors.alwaysWhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 3),
                                      Icon(
                                        Icons.search_rounded,
                                        size: 20,
                                        color: colors.alwaysWhite,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(),
                              const SizedBox(height: 2),
                            ],
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        ...reduceList().map((e) {
                          if (e.text.isEmpty) {
                            return const SizedBox();
                          }
                          return GestureDetector(
                            onTap: () {
                              closeDropDown();
                              widget.onSelected(e.value);
                            },
                            child: Container(
                              height: 50,
                              color: colors.transparent,
                              child: Row(
                                children: [
                                  e.prefix ?? const SizedBox(),
                                  Expanded(
                                    child: Text(
                                      e.text,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: colors.alwaysWhite,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Iterable<CustomDropDownItem<dynamic>> reduceList() {
    return (fList ?? items).where((element) =>
        selectedItem.value != element.value && element.value != null);
  }

  double calculateHeight() {
    if (expanded) {
      if (!widget.searchable) {
        var calculatedHeight =
            (27.0 + (52.0 * (items.where((e) => e.text.isNotEmpty).length)));
        if (calculatedHeight > (widget.maxHeight ?? calculatedHeight)) {
          calculatedHeight = widget.maxHeight ?? calculatedHeight;
        }
        return calculatedHeight;
      }
      var other = fList != null
          ? fList!.where((e) => e.text.isNotEmpty).length
          : (items.where((e) => e.text.isNotEmpty).length - 1);
      return widget.maxHeight ?? (130) + (52.0 * other) + 5;
    }
    return widget.minHeight;
  }

  void closeDropDown() {
    setState(() {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      expanded = false;
    });
  }

  void setSelectedItem(T item) {
    setState(() {
      items = widget.items;
      final selectedItemIndex = items.indexWhere(
        (element) => element.value == item,
      );
      if (selectedItemIndex == -1) {
        selectedItem = items.first;
      } else {
        selectedItem = items[selectedItemIndex];
      }
    });
  }
}

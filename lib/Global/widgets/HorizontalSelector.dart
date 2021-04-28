import 'package:flutter/material.dart';

class HorizontalSelector<T> extends StatefulWidget {
  final List<MapEntry<T,String>> items;
  final T initialSelection;
  final void Function(T) onChange;
  const HorizontalSelector({Key? key, required this.items, required this.initialSelection, required this.onChange}) : super(key: key);
  @override
  _HorizontalSelectorState<T> createState() => _HorizontalSelectorState<T>();
}

class _HorizontalSelectorState<T> extends State<HorizontalSelector<T>> with AutomaticKeepAliveClientMixin {

  late T selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialSelection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.items.map((e) {
          return InkWell(
            onTap: () {
              if(selectedValue!=e.key) setState(() {
                selectedValue = e.key;
                widget.onChange(selectedValue);
              });
            },
            child: Card(
              elevation: 4, shadowColor: Colors.black54,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(e.value, style: TextStyle(color: selectedValue == e.key ? Colors.white : Colors.black),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: selectedValue == e.key ? Colors.green.shade700 : Colors.white,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override bool get wantKeepAlive => true;
}
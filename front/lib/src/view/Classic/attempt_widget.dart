import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyledle/src/controller/Classic/classic_controller.dart';
import 'package:kyledle/src/view/Classic/delayed_display_widget.dart';

class Attempt extends StatefulWidget {
  const Attempt({
    super.key,
    required this.animate,
    required this.attempt,
    required this.controller,
  });
  final bool animate;
  final String attempt;
  final ClassicController controller;

  @override
  AttemptState createState() => AttemptState();
}

class AttemptState extends State<Attempt> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            widget.controller.columns.asMap().entries.map<Widget>((entry) {
          final value = widget.controller.characters[widget.attempt]["columns"]
              [entry.value];
          final searchedValue = widget.controller
              .characters[widget.controller.target]["columns"][entry.value];
          String displayValue;
          Color? color;

          if (value is List) {
            final valueSet = Set.from(value);
            final searchedValueSet = Set.from(searchedValue);

            if (valueSet.containsAll(searchedValueSet) &&
                searchedValueSet.containsAll(valueSet)) {
              color = Colors.green;
            } else if (valueSet.intersection(searchedValueSet).isNotEmpty) {
              color = Colors.yellow[700];
            } else {
              color = Colors.red;
            }
            displayValue = value.join(", ");
          } else {
            displayValue = value.toString().trim();
            color = value == searchedValue ? Colors.green : Colors.red;
          }

          if (entry.key == 0) {
            color = Colors.white;
          }

          return DelayedDisplay(
            key: ValueKey(
              widget.attempt + widget.controller.columns[entry.key],
            ),
            animate: widget.animate,
            controller: widget.controller,
            delay: Duration(milliseconds: 500 * entry.key),
            isFirst: entry.key == 0,
            isLast: entry.key + 1 == widget.controller.columns.length,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(width: 3),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: displayValue.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: value,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : Text(
                        displayValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          );
        }).toList(),
      );
}

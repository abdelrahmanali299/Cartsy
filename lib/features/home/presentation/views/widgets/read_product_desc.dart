import 'package:flutter/material.dart';

class ReadProductDesc extends StatefulWidget {
  const ReadProductDesc({super.key, required this.desc});
  final String desc;

  @override
  State<ReadProductDesc> createState() => _ReadProductDescState();
}

class _ReadProductDescState extends State<ReadProductDesc> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            widget.desc,
            maxLines: isExpanded ? null : 3,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
        ),

        TextButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: widget.desc.length > 100
              ? Text(
                  isExpanded ? 'Read Less' : 'Read More',
                  style: TextStyle(color: Colors.blue),
                )
              : const Text(''),
        ),
      ],
    );
  }
}

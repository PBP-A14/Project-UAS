import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    if (!_isActive) {
      return OutlinedButton(
        onPressed: () {
          // setState(() {
          //   _isActive = !_isActive;
          // });
          showDialog(
            context: context,
            // barrierDismissible: false,
            builder: (context) {
              return FilterDialog();
            },
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black.withOpacity(.1);
            }
            return Colors.transparent;
          }),
        ),
        child: const Icon(Icons.filter_list),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          setState(() {
            _isActive = !_isActive;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: const Icon(Icons.filter_list),
      );
    }
  }

  @override
  void dispose() {
    _isActive = false;
    super.dispose();
  }
}

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('A to Z'),
          Divider(),
          Text('Z to A'),
          Divider(),
          Text('None')
        ],
      ),
    );
  }
}

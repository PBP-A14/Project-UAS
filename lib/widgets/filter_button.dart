import 'package:elibrary/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<HomeProvider>(context);
    if (filterProvider.isZAChecked || filterProvider.isAZChecked) {
      return Row(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                // barrierDismissible: false,
                builder: (context) {
                  return const FilterDialog();
                },
              );
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
          ),
          const SizedBox(width: 8),
          if (filterProvider.isAZChecked)
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<HomeProvider>(context, listen: false).resetFilter();
              },
              icon: Icon(Icons.clear),
              label: const Text('A to Z'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          if (filterProvider.isZAChecked)
            ElevatedButton.icon(
              onPressed: () {
                Provider.of<HomeProvider>(context, listen: false).resetFilter();
              },
              icon: Icon(Icons.clear),
              label: const Text('Z to A'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      );
    } else {
      return OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            // barrierDismissible: false,
            builder: (context) {
              return const FilterDialog();
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
    }
  }
}

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<HomeProvider>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Filter'),
      backgroundColor: const Color(0xFFF1F2F4),
      surfaceTintColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: filterProvider.isAZChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      if (filterProvider.isZAChecked) {
                        filterProvider.toggleZA(!filterProvider.isZAChecked);
                      }
                      filterProvider.toggleAZ(value!);
                    });
                  }),
              const Text('A to Z'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: filterProvider.isZAChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      if (filterProvider.isAZChecked) {
                        filterProvider.toggleAZ(!filterProvider.isAZChecked);
                      }
                      filterProvider.toggleZA(value!);
                    });
                  }),
              const Text('Z to A'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (filterProvider.isAZChecked) {
              filterProvider.setFilterAZ();
            } else if (filterProvider.isZAChecked) {
              filterProvider.setFilterZA();
            } else {
              filterProvider.fetchBook();
            }
            Navigator.pop(context);
          },
          child: const Text('Close'),
        )
      ],
    );
  }
}

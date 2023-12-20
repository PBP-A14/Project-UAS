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
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false, // TODO: GK GUNAA??
                builder: (context) {
                  return const FilterDialog();
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (filterProvider.isAZChecked)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                child: Row(
                  children: [
                    const Text('A to Z'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .resetFilter();
                      },
                      child: const Icon(Icons.clear),
                    )
                  ],
                ),
              ),
            ),
          if (filterProvider.isZAChecked)
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 12, 8),
                child: Row(
                  children: [
                    const Text('Z to A'),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        Provider.of<HomeProvider>(context, listen: false)
                            .resetFilter();
                      },
                      child: const Icon(Icons.clear),
                    ),
                  ],
                ),
              ),
            ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            // barrierDismissible: false,
            builder: (context) {
              return const FilterDialog();
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.filter_list),
          ),
        ),
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
  bool isAZ = false;
  bool isZA = false;

  @override
  void initState() {
    super.initState();
    final filterProvider = Provider.of<HomeProvider>(context, listen: false);
    isAZ = filterProvider.isAZChecked;
    isZA = filterProvider.isZAChecked;
  }

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
                  // value: filterProvider.isAZChecked,
                  value: isAZ,
                  onChanged: (bool? value) {
                    setState(() {
                      if (isZA) {
                        isZA = !isZA;
                      }
                      isAZ = !isAZ;
                      // if (filterProvider.isZAChecked) {
                      //   filterProvider.toggleZA(!filterProvider.isZAChecked);
                      // }
                      // filterProvider.toggleAZ(value!);
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
                  // value: filterProvider.isZAChecked,
                  value: isZA,
                  onChanged: (bool? value) {
                    setState(() {
                      if (isAZ) {
                        isAZ = !isAZ;
                      }
                      isZA = !isZA;
                      // if (filterProvider.isAZChecked) {
                      //   filterProvider.toggleAZ(!filterProvider.isAZChecked);
                      // }
                      // filterProvider.toggleZA(value!);
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
            if (isAZ) {
              filterProvider.toggleAZ(true);
              filterProvider.toggleZA(false);
              filterProvider.setFilterAZ();
            } else if (isZA) {
              filterProvider.toggleAZ(false);
              filterProvider.toggleZA(true);
              filterProvider.setFilterZA();
            } else {
              filterProvider.toggleAZ(false);
              filterProvider.toggleZA(false);
              filterProvider.resetFilter();
            }
            Navigator.pop(context);
          },
          child: const Text('Close'),
        )
      ],
    );
  }
}

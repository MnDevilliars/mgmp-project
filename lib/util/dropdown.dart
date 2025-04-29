import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<dynamic> options;
  final String label;
  final Function(String selectedValue) onChanged;
  final double heightFactor;
  final double width;
  final String? initialValue;
  final String keyInfo;

  const Dropdown({
    Key? key,
    required this.options,
    required this.onChanged,
    required this.label,
    required this.keyInfo,
    this.heightFactor = 0.9,
    this.width = 150,
    this.initialValue,
  }) : super(key: key);

  @override
  State<Dropdown> createState() => _Dropdown();
}

class _Dropdown extends State<Dropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  void _openCustomDropdown(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: widget.heightFactor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B61FF),
                  ),
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    final value = option[widget.keyInfo];
                    final isSelected = value == selectedValue;

                    return Card(
                      color: isSelected ? const Color(0xFF7B61FF).withOpacity(0.8) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF7B61FF)
                              : const Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                      elevation: 2,
                      shadowColor: Colors.grey.withOpacity(0.3),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          value ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                        onTap: () => Navigator.pop(context, value),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null && result != selectedValue) {
      setState(() {
        selectedValue = result;
      });
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openCustomDropdown(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Color(0xFF7B61FF),
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          suffixIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFF7B61FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF927EFF),
              width: 1.5,
            ),
          ),
        ),
        isEmpty: selectedValue == null || selectedValue!.isEmpty,
        child: Text(
          selectedValue ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

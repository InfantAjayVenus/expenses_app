import 'package:flutter/material.dart';
import 'package:expenses_app/models/expense_record.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onSave});

  final void Function(ExpenseRecord) onSave;

  @override
  State<ExpenseForm> createState() {
    return _ExpenseFormState();
  }
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category? _selecetdCategory;

  _showDatePicker() async {
    var now = DateTime.now();
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  _saveValues() {
    var amountParsed = double.tryParse(_amountController.text);

    bool isTitleValid = _titleController.text.isNotEmpty;
    bool isAmountValid = amountParsed != null && amountParsed >= 0.0;
    bool isDateValid = _selectedDate != null;
    bool isCategoryValid = _selecetdCategory != null;

    if (!(isTitleValid && isAmountValid && isDateValid && isCategoryValid)) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please ensure to enter a valid Title, Amount, Date and Category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );

      return;
    }

    widget.onSave(ExpenseRecord(
      title: _titleController.text,
      amount: amountParsed,
      category: _selecetdCategory!,
      date: _selectedDate,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 80,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefixText: '₹',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate != null
                        ? dateFormatter.format(_selectedDate!)
                        : 'Select Date'),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              DropdownButton(
                hint: const Text('Category'),
                value: _selecetdCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: [
                              Icon(
                                categoryIcons[category],
                                size: 16,
                              ),
                              Text(category.name.toString().toUpperCase()),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selecetdCategory = value;
                  });
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.redAccent),
                      onPressed: () => {Navigator.pop(context)},
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: _saveValues,
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

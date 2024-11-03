import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/widgets/navigation_bar.dart';

class AddExpensePage extends StatelessWidget {
  AddExpensePage({super.key});

  final navigationController = Get.find<NavigationController>();
  final entryController = Get.find<EntryController>();
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      var values = _formKey.currentState!.value;
      var entry = ExpenseEntry.create(
        BigInt.from((values["value"] * 100)),
        values["category"],
        values["date"],
      );
      entryController.addExpense(entry);
      _formKey.currentState?.reset();
      navigationController.setTabIndexOff(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            FormBuilderTextField(
              name: "value",
              decoration: const InputDecoration(
                labelText: "Cost",
                prefixText: "\$",
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: true),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.positiveNumber(),
                FormBuilderValidators.max(1e15 - 1),
              ]),
              valueTransformer: (value) {
                if (value != null) {
                  final parsed = double.tryParse(value);
                  if (parsed != null && parsed.isFinite) {
                    return parsed;
                  }
                }
                return value;
              },
            ),
            FormBuilderDropdown(
              name: "category",
              decoration: const InputDecoration(
                labelText: "Category",
                hintText: "What type of expense are you adding?",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "housing",
                  child: Text("Housing"),
                ),
                DropdownMenuItem(
                  value: "transportation",
                  child: Text("Transportation"),
                ),
                DropdownMenuItem(
                  value: "groceries",
                  child: Text("Food & Groceries"),
                ),
                DropdownMenuItem(
                  value: "entertainment",
                  child: Text("Entertainment"),
                ),
                DropdownMenuItem(
                  value: "debt",
                  child: Text("Debt Repayment"),
                ),
                DropdownMenuItem(
                  value: "insurance",
                  child: Text("Insurance"),
                ),
                DropdownMenuItem(
                  value: "health",
                  child: Text("Health & Wellness"),
                ),
                DropdownMenuItem(
                  value: "personal_care",
                  child: Text("Personal Care"),
                ),
                DropdownMenuItem(
                  value: "education",
                  child: Text("Education"),
                ),
                DropdownMenuItem(
                  value: "family",
                  child: Text("Child & Family Care"),
                ),
                DropdownMenuItem(
                  value: "savings",
                  child: Text("Savings & Investments"),
                ),
                DropdownMenuItem(
                  value: "other",
                  child: Text("Other"),
                ),
              ],
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            FormBuilderDateTimePicker(
              name: "date",
              currentDate: DateTime.now(),
              initialValue: DateTime.now(),
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: "Date",
                hintText: "When did you receive this expense?",
                border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
            ElevatedButton.icon(
              onPressed: _submit,
              label: const Text("Add expense"),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Add Expense"),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

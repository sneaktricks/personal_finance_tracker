import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:personal_finance_tracker/src/controllers/entry_controller.dart';
import 'package:personal_finance_tracker/src/controllers/navigation_controller.dart';
import 'package:personal_finance_tracker/src/models/models.dart';
import 'package:personal_finance_tracker/src/utils/categoryid_to_text.dart';
import 'package:personal_finance_tracker/src/widgets/constrained_view.dart';

class AddIncomePage extends StatelessWidget {
  AddIncomePage({super.key});

  final navigationController = Get.find<NavigationController>();
  final entryController = Get.find<EntryController>();
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    if (_formKey.currentState!.saveAndValidate()) {
      var values = _formKey.currentState!.value;
      var entry = IncomeEntry.create(
        BigInt.from((values["value"] * 100)),
        values["category"],
        values["date"],
      );
      entryController.addIncome(entry);
      _formKey.currentState?.reset();
      navigationController.setTabIndexOff(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedView(
        omitNavRail: true,
        maxWidth: 500,
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              FormBuilderTextField(
                name: "value",
                decoration: const InputDecoration(
                  labelText: "Income value",
                  prefixText: "\$",
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.positiveNumber(),
                  FormBuilderValidators.min(0.01),
                  FormBuilderValidators.max(1e15 - 1),
                ]),
                valueTransformer: (value) {
                  if (value != null) {
                    final parsed = double.tryParse(value);
                    if (parsed != null && parsed.isFinite) {
                      return parsed;
                    }
                  }
                  return 0;
                },
              ),
              const SizedBox(height: 10),
              FormBuilderDropdown(
                name: "category",
                decoration: const InputDecoration(
                  labelText: "Category",
                  hintText: "What type of income did you receive?",
                  border: OutlineInputBorder(),
                ),
                items: incomeCategories
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text.rich(
                          TextSpan(children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(categoryIdToIcon[e]),
                            ),
                            TextSpan(text: categoryIdToName[e] ?? "Unknown"),
                          ]),
                        )))
                    .toList(),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: "date",
                currentDate: DateTime.now(),
                initialValue: DateTime.now(),
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: "Date",
                  hintText: "When did you receive this income?",
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submit,
                label: const Text("Add income"),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text("Add Income"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_button.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_input.dart';

class AddIngredientDialog extends StatefulWidget {
  const AddIngredientDialog({super.key});

  @override
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onTextChanged);
    _countController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onTextChanged);
    _countController.removeListener(_onTextChanged);
    _nameController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'count': _countController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // ← убирает скругление
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          left: 16,
          right: 16,
          bottom: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ингредиент', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              AppInput(
                labelText: "Название ингредиента",
                controller: _nameController,
                validator: (value) => value?.isEmpty == true
                    ? 'Введите название ингредиента'
                    : null,
              ),
              const SizedBox(height: 12),
              AppInput(
                labelText: "Количество",
                controller: _countController,
                validator: (value) =>
                    value?.isEmpty == true ? 'Введите количество' : null,
              ),
              const SizedBox(height: 50),
              Align(
                alignment: AlignmentGeometry.center,
                child: AppButton(
                  filled: true,
                  text:
                      _nameController.text.isNotEmpty &&
                          _countController.text.isNotEmpty
                      ? 'Сохранить'
                      : 'Добавить',
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

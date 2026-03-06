import 'package:flutter/material.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_button.dart';
import 'package:flutter_food_otus/ui/recipes/widgets/app_input.dart';
import 'package:flutter_food_otus/utils/input_validators.dart';

class AddStepDialog extends StatefulWidget {
  const AddStepDialog({super.key});

  @override
  State<AddStepDialog> createState() => _AddStepDialogState();
}

class _AddStepDialogState extends State<AddStepDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    _minutesController.addListener(_onTextChanged);
    _secondsController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _minutesController.removeListener(_onTextChanged);
    _secondsController.removeListener(_onTextChanged);
    _textController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, (
        name: _textController.text,
        minutes: _minutesController.text.isEmpty
            ? 0
            : int.parse(_minutesController.text),
        seconds: _secondsController.text.isEmpty
            ? 0
            : int.parse(_secondsController.text),
      ));
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
        child: OrientationBuilder(
          builder: (context, orientation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = orientation == Orientation.landscape
                    ? constraints.maxWidth * 0.5
                    : constraints.maxWidth;
                return SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Шаг рецепта',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            AppInput(
                              labelText: "Описание шага",
                              multiline: true,
                              controller: _textController,
                              validator: (value) => value?.isEmpty == true
                                  ? 'Введите описание шага'
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Длительность шага',
                              style: TextStyle(fontSize: 10),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: AppInput(
                                    labelText: "Минуты",
                                    numeric: true,
                                    controller: _minutesController,
                                    validator: (value) =>
                                        value?.isEmpty == true &&
                                            _secondsController.text.isEmpty
                                        ? 'Введите минуты'
                                        : validateNumber(value),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: AppInput(
                                    labelText: "Секунды",
                                    numeric: true,
                                    controller: _secondsController,
                                    validator: (value) =>
                                        value?.isEmpty == true &&
                                            _minutesController.text.isEmpty
                                        ? 'Введите секунды'
                                        : validateNumber(
                                            value,
                                            isSeconds: true,
                                          ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 50),
                            Align(
                              alignment: AlignmentGeometry.center,
                              child: AppButton(
                                filled: true,
                                text:
                                    _textController.text.isNotEmpty &&
                                        (_minutesController.text.isNotEmpty ||
                                            _secondsController.text.isNotEmpty)
                                    ? 'Сохранить'
                                    : 'Добавить',
                                onPressed: onSubmit,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

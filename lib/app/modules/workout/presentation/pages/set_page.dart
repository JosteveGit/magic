import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/functions/string_functions.dart';
import 'package:magic/app/shared/helpers/classes/media/pngs.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_dropdown.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';
import 'package:magic/core/navigation/navigator.dart';

class SetPage extends ConsumerStatefulWidget {
  final SetModel? set;
  final Function(SetModel) onSave;
  const SetPage({
    super.key,
    this.set,
    required this.onSave,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetPageState();
}

class _SetPageState extends ConsumerState<SetPage> {
  List<(SetType, String)> get types {
    return [
      (SetType.barbellRow, Pngs.barbellRow),
      (SetType.benchPress, Pngs.benchPress),
      (SetType.shoulderPress, Pngs.shoulderPress),
      (SetType.deadlift, Pngs.deadlift),
      (SetType.squat, Pngs.squat),
    ];
  }

  SetType selectedType = SetType.barbellRow;
  String weight = "";
  String repetitions = "";

  final TextEditingController weightController = TextEditingController();
  final TextEditingController repetitionsController = TextEditingController();

  @override
  void initState() {
    if (widget.set != null) {
      final preset = widget.set!;
      selectedType = preset.setType;
      weight = preset.weight.toString();
      repetitions = preset.repetitions.toString();
      weightController.text = weight;
      repetitionsController.text = repetitions;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.read(appThemeProvider).colors;
    return Scaffold(
      backgroundColor: colors.alwaysBlack,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const MagicAppBar(title: "Set"),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomDropDown(
                        header: "Type",
                        items: [
                          for (final type in types)
                            CustomDropDownItem(
                              value: type.$1,
                              text: capitalize(type.$1.name),
                              prefix: Builder(builder: (context) {
                                final isNotSelected = selectedType != type.$1;
                                return Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: MagicImage(
                                    image: type.$2,
                                    width: 15,
                                    color: isNotSelected
                                        ? colors.secondary
                                        : colors.primary,
                                    iconColor: isNotSelected
                                        ? colors.alwaysWhite
                                        : colors.secondary,
                                  ),
                                );
                              }),
                            )
                        ],
                        onSelected: (value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                        value: selectedType,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Weight (kg)",
                        keyboardType: TextInputType.number,
                        textEditingController: weightController,
                        onChanged: (value) {
                          weight = value;
                          setState(() {});
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        headerText: "Repetitions",
                        keyboardType: TextInputType.number,
                        textEditingController: repetitionsController,
                        onChanged: (value) {
                          repetitions = value;
                          setState(() {});
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                text: "Save",
                onPressed: () {
                  pop(context);
                  final model = SetModel(
                    setType: selectedType,
                    weight: double.parse(weight),
                    repetitions: int.parse(repetitions),
                  );
                  widget.onSave(model);
                },
                validator: () {
                  if (weight.isEmpty || repetitions.isEmpty) {
                    return false;
                  }
                  if (widget.set != null) {
                    final oldSet = widget.set!;
                    final newWeight = double.parse(weight);
                    final newRepetitions = int.parse(repetitions);

                    if (oldSet.setType == selectedType &&
                        oldSet.weight == newWeight &&
                        oldSet.repetitions == newRepetitions) {
                      return false;
                    }
                  }
                  return true;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

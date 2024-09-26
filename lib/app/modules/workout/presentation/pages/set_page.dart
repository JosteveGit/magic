import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/shared/helpers/classes/media/pngs.dart';
import 'package:magic/app/shared/presentation/widgets/custom_button.dart';
import 'package:magic/app/shared/presentation/widgets/custom_dropdown.dart';
import 'package:magic/app/shared/presentation/widgets/custom_textfield.dart';
import 'package:magic/app/shared/presentation/widgets/magic_app_bar.dart';
import 'package:magic/app/shared/presentation/widgets/magic_icon.dart';
import 'package:magic/core/framework/theme/colors/app_theme_provider.dart';

class SetPage extends ConsumerStatefulWidget {
  const SetPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetPageState();
}

class _SetPageState extends ConsumerState<SetPage> {
  List<(String, String)> get types {
    return [
      ("Barbell Row", Pngs.barbellRow),
      ("Bench Press", Pngs.benchPress),
      ("Shoulder Press", Pngs.shoulderPress),
      ("Deadlift", Pngs.deadlift),
      ("Squat", Pngs.squat),
    ];
  }

  String selectedType = "Barbell Row";

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
                              text: type.$1,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

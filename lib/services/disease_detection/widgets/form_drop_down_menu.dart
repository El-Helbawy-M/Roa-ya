import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import '../../../componants/animated_widgets.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_text_styles.dart';
import '../model/custom_model_sheet.dart';

class FormSelector extends StatefulWidget {
  const FormSelector({
    required this.label,
    required this.value,
    required this.onTap,
    required this.data,
    this.hasError = false,
    this.errorText,
    Key? key,
  }) : super(key: key);
  final String? label;
  final CustomModelSheet? value;
  final Function(CustomModelSheet) onTap;
  final List<CustomModelSheet> data;
  final bool hasError;
  final String? errorText;
  @override
  State<FormSelector> createState() => _FormSelectorState();
}

class _FormSelectorState extends State<FormSelector> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: AppTextStyles.w500.copyWith(fontSize: 15),
        ),
        SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: EdgeInsets.symmetric(vertical: 4),
          height: isExpanded ? 300 : 50,
          decoration: BoxDecoration(
            color: AppColors.lightFieldColor.withOpacity(.6),
            borderRadius: BorderRadius.circular(10),
            // border: value == ""
            //     ? Border.all(style: BorderStyle.none)
            //     : Border.all(width: 1, color: Styles.PRIMARY_COLOR),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.inputFieldColor,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: !isExpanded ? Radius.circular(10) : Radius.circular(0)),
                    border: Border.all(style: BorderStyle.none),
                    // border: value == ""
                    //     ? Border.all(style: BorderStyle.none)
                    //     : Border.all(width: 1, color: Styles.PRIMARY_COLOR),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.value == null ? widget.label! : widget.value!.name!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.w500.copyWith(
                              fontSize: 12,
                              color: widget.value == "" ? Colors.grey : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 400),
                        turns: isExpanded ? 0.5 : 0,
                        child: SizedBox(width: 18,height: 18,child: customImageIconSVG(imageName: "arrow_down",color: widget.hasError? AppColors.inActive:AppColors.mainColor)),
                      )
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListAnimator(
                      controller: ScrollController(),
                      data: List.generate(
                        widget.data.length,
                        (index) => Column(
                          children: [
                            ListTile(
                              title: Text(widget.data[index].name ?? "", style: TextStyle(fontWeight: FontWeight.w600)),
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                                widget.onTap(widget.data[index]);
                              },
                            ),
                            const Divider(height: 5),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.hasError)
          Text(
            widget.errorText ?? "شسب",
            style: AppTextStyles.w400.copyWith(fontSize: 14, color: AppColors.inActive),
          ),
      ],
    );
  }
}

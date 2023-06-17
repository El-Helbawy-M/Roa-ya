import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:graduation_project/helpers/file_picker_helper.dart';
import 'package:path/path.dart';

import '../helpers/app_text_styles.dart';
import '../helpers/image_picker_helper.dart';
import 'custom_button.dart';

class UploadFile extends StatefulWidget {
  final Function(File?)? updatedImage;

  final ValueChanged? updateFile;
  final bool isFilled;
  final bool hasError;
  final String? errorText;
  final String? label;
  final File? selectedFile;

  const UploadFile({Key? key, required this.updatedImage, this.label, this.selectedFile, this.isFilled = false, this.updateFile, this.hasError = false, this.errorText}) : super(key: key);

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  File? image;

  @override
  Widget build(BuildContext context) {
    image = widget.selectedFile;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              // ImagePickerHelper.showOption(onGet: (file) async {
              //   setState(() => image = file);
              //   var multipartImage = await MultipartFile.fromFile(image!.path);
              //   widget.updatedImage!(file);
              //   if (widget.updateFile != null) widget.updateFile!(image);
              // });
              FilePickerHelper.pickFile(
                  title: "Pick an File",
                  allowedExtensions: ['jpg', 'png', "xml"],
                  onSelected: (file) async {
                    setState(() => image = file);
                    var multipartImage = await MultipartFile.fromFile(image!.path);
                    widget.updatedImage!(file);
                    if (widget.updateFile != null) widget.updateFile!(image);
                  });
            },
            child: Container(
              height: image != null ? 230 : 180,
              width: MediaHelper.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    width: 1,
                    color: widget.isFilled ? AppColors.mainColor : (widget.hasError ? AppColors.inActive : AppColors.borderColor),
                  )
                  // image: DecorationImage(
                  //     image: Image.asset(
                  //             'assets/images/${image != null ? "uploaded_image" : "upload_image"}.png')
                  //         .image,
                  //     fit: BoxFit.fill),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                      child: image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.fill,
                            )
                          : customImageIconSVG(imageName: 'gallery', color: (widget.hasError ? AppColors.inActive : AppColors.borderColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    image != null
                        ? "Upload!"
                        : widget.label != null
                            ? widget.label!
                            : "Upload Image",
                    style: TextStyle(color: AppColors.header, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: RichText(
                      text: TextSpan(text: image != null ? basename(image!.path) : 'must be less than', style: TextStyle(color: AppColors.subHeader, fontSize: 11, fontWeight: FontWeight.w500), children: [TextSpan(text: image != null ? "" : ' 6MB', style: TextStyle(color: AppColors.header, fontSize: 11, fontWeight: FontWeight.w600))]),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  Visibility(
                    visible: image != null,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomBtn(
                              text: "Change",
                              btnHeight: 31,
                              btnWidth: 84,
                              txtFontSize: 12,
                              onTap: () {
                                // ImagePickerHelper.showOption(onGet: (file) async {
                                //   setState(() => image = file);
                                //   var multipartImage = await MultipartFile.fromFile(image!.path);
                                //   widget.updatedImage!(file);
                                //   if (widget.updateFile != null) widget.updateFile!(image);
                                // });
                                FilePickerHelper.pickFile(
                                    title: "Pick an File",
                                    allowedExtensions: ['jpg', 'png', "xml"],
                                    onSelected: (file) async {
                                      setState(() => image = file);
                                      var multipartImage = await MultipartFile.fromFile(image!.path);
                                      widget.updatedImage!(file);
                                      if (widget.updateFile != null) widget.updateFile!(image);
                                    });
                              },
                              color: AppColors.mainColor,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            CustomBtn(
                              btnWidth: 84,
                              text: "Remove",
                              btnHeight: 31,
                              txtFontSize: 12,
                              onTap: () {
                                setState(() => image = null);
                                widget.updatedImage!(null);
                                if (widget.updateFile != null) widget.updateFile!(null);
                              },
                              color: AppColors.inActive.withOpacity(.1),
                              txtColor: AppColors.inActive,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (widget.hasError)
          Text(
            widget.errorText ?? "",
            style: AppTextStyles.w400.copyWith(fontSize: 14, color: AppColors.inActive),
          )
      ],
    );
  }
}

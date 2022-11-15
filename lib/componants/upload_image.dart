// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/helpers/app_media_query.dart';
// import 'package:path/path.dart';

// class UploadFileWidget extends StatefulWidget {
//   final ValueChanged? updatedFile;

//   final ValueChanged? updateFile;

//   final String? label;

//   final File? selectedFile;

//   const UploadFileWidget(
//       {Key? key,
//       required this.updatedFile,
//       this.label,
//       this.selectedFile,
//       this.updateFile})
//       : super(key: key);

//   @override
//   State<UploadFileWidget> createState() => _UploadFileWidgetState();
// }

// class _UploadFileWidgetState extends State<UploadFileWidget> {
//   File? file;

//   @override
//   void initState() {
//     if (widget.selectedFile != null) file = widget.selectedFile;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Container(
//             height: file != null ? 192 : 140,
//             width: MediaHelper.width,
//             decoration: BoxDecoration(
//               color: Colors.blue, // it will be modified later
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () async {
//                     FilePickerResult? result =
//                         await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       file = File(result.files.single.path!);
//                       setState(() {
//                         var multipartImage = MultipartFile.fromFile(file!.path);
//                         widget.updatedFile!(multipartImage);
//                         if (widget.updateFile != null) {
//                           widget.updateFile!(file);
//                         }
//                       });
//                     }
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Container(
//                       height: 44,
//                       width: 44,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0)),
//                       child: null // will be modified later
//                       //  image != null
//                       //     ? Image.file(
//                       //         image!,
//                       //         fit: BoxFit.fill,
//                       //       )
//                       //     : customImageIconSVG(imageName: 'blue_gallery'),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Text(""
//                   // image != null
//                   //     ? "${allTranslations.text("Uploaded")}!"
//                   //     : widget.label != null
//                   //         ? widget.label!
//                   //         : allTranslations.text("Upload Image"),
//                   ,style: TextStyle(
//                       color: Colors.amber,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 6,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: RichText(
//                     text: TextSpan(
//                         text: file != null
//                             ? basename(file!.path)
//                             : 'must be less than',
//                         style: TextStyle(
//                             color: Colors.lightGreenAccent,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w500),
//                         children: [
//                           TextSpan(
//                               text: file != null ? "" : ' 6MB',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w600))
//                         ]),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                   ),
//                 ),
//                 // Visibility(
//                 //   visible: file != null,
//                 //   child: Column(
//                 //     children: [
//                 //       SizedBox(
//                 //         height: 16.0,
//                 //       ),
//                 //       Row(
//                 //         mainAxisAlignment: MainAxisAlignment.center,
//                 //         children: [
//                 //           CustomBtn(
//                 //             text: allTranslations.text("Change"),
//                 //             btnHeight: 31,
//                 //             btnWidth: 84,
//                 //             txtFontSize: 12,
//                 //             onTap: () {
//                 //               ImagePickerHelper.showOption(onGet: (file) async {
//                 //                 setState(() => image = file);
//                 //                 var multipartImage =
//                 //                     await MultipartFile.fromFile(image!.path);
//                 //                 widget.updatedFile!(multipartImage);
//                 //                 if (widget.updateFile != null)
//                 //                   widget.updateFile!(image);
//                 //               });
//                 //             },
//                 //             color: AppColors.PRIMARY_COLOR,
//                 //           ),
//                 //           SizedBox(
//                 //             width: 8.0,
//                 //           ),
//                 //           CustomBtn(
//                 //             btnWidth: 84,
//                 //             text: allTranslations.text("Remove"),
//                 //             btnHeight: 31,
//                 //             txtFontSize: 12,
//                 //             onTap: () {
//                 //               setState(() => image = null);
//                 //               widget.updatedFile!(null);
//                 //               if (widget.updateFile != null)
//                 //                 widget.updateFile!(null);
//                 //             },
//                 //             color: AppColors.IN_ACTIVE.withOpacity(.1),
//                 //             txtColor: AppColors.IN_ACTIVE,
//                 //           ),
//                 //         ],
//                 //       )
//                 //     ],
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/componants/custom_icon.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_media_query.dart';
import 'package:path/path.dart';

import '../helpers/image_picker_helper.dart';
import 'custom_button.dart';

class UploadImage extends StatefulWidget {
  final Function(MultipartFile?)? updatedImage;

  final ValueChanged? updateFile;
  final bool isFilled;

  final String? label;

  final File? selectedImage;

  const UploadImage({Key? key, required this.updatedImage, this.label, this.selectedImage, this.isFilled = false, this.updateFile}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;

  @override
  void initState() {
    if (widget.selectedImage != null) image = widget.selectedImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              ImagePickerHelper.showOption(onGet: (file) async {
                setState(() => image = file);
                var multipartImage = await MultipartFile.fromFile(image!.path);
                widget.updatedImage!(multipartImage);
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
                    color: widget.isFilled? AppColors.mainColor : AppColors.borderColor,
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
                          : customImageIconSVG(imageName: 'gallery', color: AppColors.mainColor),
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
                                ImagePickerHelper.showOption(onGet: (file) async {
                                  setState(() => image = file);
                                  var multipartImage = await MultipartFile.fromFile(image!.path);
                                  widget.updatedImage!(multipartImage);
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
      ],
    );
  }
}

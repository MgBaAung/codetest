import 'package:b2b_freshmore/presentation/global/app_theme.dart';
import 'package:b2b_freshmore/presentation/global/color_constant.dart';
import 'package:b2b_freshmore/presentation/global/extension/num_extension.dart';
import 'package:b2b_freshmore/presentation/global/extension/text_extension.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ChooseFileWidget extends StatefulWidget {
  final void Function(File?)? callBack;
  const ChooseFileWidget({super.key, required this.callBack});

  @override
  State<ChooseFileWidget> createState() => _ChooseFileWidgetState();
}

class _ChooseFileWidgetState extends State<ChooseFileWidget> {
  File? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedFile = File(image.path);
        widget.callBack?.call(_selectedFile);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 44.v,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstant.whiteColor,
          border: Border.all(color: ColorConstant.borderStoke),
        ),
        child: Row(
          children: [
            Padding(
              padding: [0, 10].symmetricPadding,
              child: Text("Chosen File", style: context.regular(fSize: 16)),
            ),
            Container(width: 1, height: 44.v, color: ColorConstant.borderStoke),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  _selectedFile != null
                      ? _selectedFile!.path.split('/').last
                      : "No file chosen",
                  style: context.regular(
                    fSize: 16,
                    color: _selectedFile != null
                        ? Colors.black
                        : ColorConstant.greyColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/widgets/image.dart';

// Reusable Submit Button Widget
class SubmitButton extends StatelessWidget {
  final RxBool isComplete;
  final VoidCallback onSubmit;

  const SubmitButton({
    super.key,
    required this.isComplete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => ElevatedButton(
            onPressed: isComplete.value ? onSubmit : null,
            child: isComplete.value
                ? const Text('إرسال')
                : const CircularProgressIndicator(),
          )),
    );
  }
}

// Generic App Dialog Widget
class AppDialog extends StatelessWidget {
  final Widget formContent;
  final GlobalKey<FormState> formKey;
  final ScrollController? scrollController;
  final ColorScheme? colorScheme;

  const AppDialog({
    super.key,
    required this.formContent,
    required this.formKey,
    this.scrollController,
    this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColorScheme = colorScheme ?? Theme.of(context).colorScheme;
    final effectiveScrollController = scrollController ?? ScrollController();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        shape: const BeveledRectangleBorder(),
        backgroundColor: effectiveColorScheme.surface,
        child: Scrollbar(
          controller: effectiveScrollController,
          child: Column(
            children: [
              _buildHeader(effectiveColorScheme),
              Expanded(
                child: SingleChildScrollView(
                  controller: effectiveScrollController,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: formContent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colorScheme) {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.dstIn),
          child: Container(
            width: double.infinity,
            height: 50,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(
          width: double.infinity,
          height: 50,
          child: ClipRRect(
            child: CustomAssetImage(assetPath: "assets/back.png"),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
              icon: Icon(Icons.close, color: colorScheme.onSurface),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ],
    );
  }
}

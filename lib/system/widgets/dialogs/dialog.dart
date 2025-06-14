import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';

/// Abstract dialog that provides a template for forms with optional edit support.
abstract class GlobalDialog extends StatefulWidget {
  final String dialogHeader;
  final int numberInputs;

  const GlobalDialog({
    super.key,
    this.dialogHeader = "add data",
    this.numberInputs = 10,
  });

  @override
  State<GlobalDialog> createState();
}

/// Base state class for form dialogs.
/// Subclasses should define formChild, loadData, submit, setDefaultFieldsValue.
abstract class DialogState<GEC extends GenericEditController>
    extends State<GlobalDialog> {
  final GlobalKey<FormState> lectureFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  late form.FormController formController;
  GEC? editController;
  RxBool isComplete = true.obs;

  /// Returns form fields as a Column.
  Column formChild();

  /// Load any necessary data (e.g. dropdowns, lists).
  Future<void> loadData();

  /// Submit the form data.
  Future<bool> submit();

  /// Pre-fill form when editing.
  void setDefaultFieldsValue();

  @override
  void initState() {
    super.initState();
    loadData();

    if (!Get.isRegistered<form.FormController>()) {
      Get.put(form.FormController(widget.numberInputs));
    }

    if (Get.isRegistered<GEC>()) {
      editController = Get.find<GEC>();
    }

    formController = Get.find<form.FormController>();
    scrollController = ScrollController();

    if (editController?.model.value != null) {
      setDefaultFieldsValue();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    formController.dispose();
    if (Get.isRegistered<ScrollController>()) {
      Get.delete<ScrollController>();
    }
    if (Get.isRegistered<form.FormController>()) {
      Get.delete<form.FormController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.55,
        maxHeight: Get.height * 0.65,
        minWidth: 300,
        minHeight: 400,
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // slight rounding
        ),
        backgroundColor: colorScheme.surface,
        child: Column(
          children: [
            /// Header section (title + close button)
            _DialogHeader(title: widget.dialogHeader),

            /// Form content with scroll
            Expanded(
              child: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: lectureFormKey,
                    child: formChild(),
                  ),
                ),
              ),
            ),

            /// Submit button at bottom
            _DialogSubmitButton(
              isComplete: isComplete,
              onSubmit: _handleSubmit,
            )
          ],
        ),
      ),
    );
  }

  /// Handles form validation and submission.
  Future<void> _handleSubmit() async {
    debugPrint('Form valid: ${lectureFormKey.currentState?.validate()}');
    debugPrint(
        'Fields: ${formController.controllers.map((c) => c.text).toList()}');

    isComplete.value = false;

    if (lectureFormKey.currentState?.validate() ?? false) {
      lectureFormKey.currentState?.save();

      try {
        final success = await submit();

        if (success) {
          Get.back(result: true);
          Get.snackbar('Success', 'Data submitted successfully',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', 'Failed to submit data',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred during submission',
            snackPosition: SnackPosition.BOTTOM);
        debugPrint('Error submitting form: $e');
      } finally {
        isComplete.value = true;
      }
    } else {
      Get.snackbar('Error', 'Please fill out all required fields',
          snackPosition: SnackPosition.BOTTOM);
      isComplete.value = true;
    }
  }
}

/// Dialog header widget with title + close button
class _DialogHeader extends StatelessWidget {
  final String title;

  const _DialogHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          )
        ],
      ),
    );
  }
}

/// Submit button with loading indicator
class _DialogSubmitButton extends StatelessWidget {
  final RxBool isComplete;
  final VoidCallback onSubmit;

  const _DialogSubmitButton({
    required this.isComplete,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Obx(() => ElevatedButton.icon(
            onPressed: isComplete.value ? onSubmit : null,
            icon: isComplete.value
                ? const Icon(Icons.send)
                : const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
            label: Text(isComplete.value ? 'Submit' : 'Submitting...'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(150, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6), // slight rounding
              ),
            ),
          )),
    );
  }
}

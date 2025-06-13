import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/form_controller.dart'
    as form;
import 'package:the_doctarine_of_the_ppl_of_the_quran/controllers/generic_edit_controller.dart';

/// An abstract dialog widget for adding or editing data,
/// parameterized by a [GenericEditController].
///
/// [dialogHeader] sets the dialog's title.
/// [numberInputs] determines the number of form fields.
abstract class GlobalDialog extends StatefulWidget {
  /// The header text displayed at the top of the dialog.
  final String dialogHeader;

  /// The number of input fields in the form.
  final int numberInputs;

  /// Creates a [GlobalDialog] with optional [dialogHeader] and [numberInputs].
  const GlobalDialog({
    super.key,
    this.dialogHeader = "add data",
    this.numberInputs = 10,
  });

  @override
  State<GlobalDialog> createState();
}

/// The state for [GlobalDialog], handling form logic and UI.
///
/// Subclasses must implement [formChild], [loadData], [submit], and [setDefaultFieldsValue].
abstract class DialogState<GEC extends GenericEditController>
    extends State<GlobalDialog> {
  /// Key for the form widget.
  final GlobalKey<FormState> lectureFormKey = GlobalKey<FormState>();

  /// Controller for scrolling the dialog content.
  late ScrollController scrollController;

  /// Controller for managing form fields.
  late form.FormController formController;

  /// Optional controller for editing existing data.
  GEC? editController;

  /// Observable indicating if the form is ready for submission.
  RxBool isComplete = true.obs;

  /// Returns the form fields as a [Column] widget.
  Column formChild();

  /// Loads any required data for the dialog.
  Future<void> loadData();

  /// Handles form submission logic.
  Future<bool> submit();

  /// Sets default values for fields in edit mode.
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
    } else {
      editController = null;
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
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        shape: BeveledRectangleBorder(),
        backgroundColor: colorScheme.surface,
        child: Scrollbar(
          controller: scrollController,
          child: Column(
            children: [
              //header
              Stack(children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstIn),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: colorScheme.primary,
                  ),
                ),
                // Dialog header text above the image
                Positioned(
                  left: 16,
                  top: 8,
                  child: Text(
                    widget.dialogHeader,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),

                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                )
              ]),

              Expanded(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: lectureFormKey,
                        child: formChild(),
                      ))),

              // Submit button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    debugPrint(
                        'Form valid: ${lectureFormKey.currentState?.validate()}');
                    debugPrint(
                        'Fields: ${formController.controllers.map((c) => c.text)}');
                    isComplete.value = false;

                    if (lectureFormKey.currentState?.validate() ?? false) {
                      // Save the form data
                      lectureFormKey.currentState?.save();
                      debugPrint('Form saved');

                      try {
                        // Depending on whether it's an edit or a new submission, call the appropriate endpoint
                        final bool success = await submit();

                        // Handle result based on success
                        if (success) {
                          Get.back(result: true);
                          Get.snackbar(
                              'Success', 'Student data submitted successfully');
                        } else {
                          // Show error message if submission failed
                          Get.snackbar(
                              'Error', 'Failed to submit lecture data');
                        }
                      } catch (e) {
                        // Handle any errors during submission
                        Get.snackbar('Error',
                            'An error occurred while submitting the form');
                        debugPrint('Error submitting form: $e');
                      } finally {
                        // Ensure to re-enable the submit button
                        isComplete.value = true;
                      }
                    } else {
                      // If form is invalid, show an error message
                      Get.snackbar(
                          'Error', 'Please fill out all required fields');
                      isComplete.value = true;
                    }
                  },
                  child: Obx(() => isComplete.value
                      ? Text('Submit')
                      : CircularProgressIndicator()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

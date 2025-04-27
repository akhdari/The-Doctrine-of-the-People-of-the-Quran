import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_doctarine_of_the_ppl_of_the_quran/system/models/post/surah_ayah.dart';
import '/system/widgets/input_field.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/acheivement.dart';
import '../../services/connect.dart';
import '../custom_container.dart';
import '../../utils/const/acheivement.dart';
import '../acheivement_block.dart';
import '../../models/post/surah_ayah_list.dart';
import 'dart:developer' as dev;

const String url = 'http://192.168.100.20/phpscript/get_guardian.php';

class AcheivemtDialog extends StatefulWidget {
  const AcheivemtDialog({super.key});

  @override
  State<AcheivemtDialog> createState() => _AcheivemtDialogState();
}

class _AcheivemtDialogState extends State<AcheivemtDialog> {
  final GlobalKey<FormState> acheivementFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;

  final Connect connect = Connect();
  final Acheivement acheivement = Acheivement();

  final SurahAyahList sessionInfoList = SurahAyahList();
  final SurahAyahList hifdList = SurahAyahList();
  final SurahAyahList quickRevList = SurahAyahList();
  final SurahAyahList majorRevList = SurahAyahList();

  RxBool isComplete = true.obs;
  BeveledRectangleBorder shape = BeveledRectangleBorder();

  @override
  void initState() {
    scrollController = ScrollController();
    sessionInfoList.surahAyahList = acheivement.sessionInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
        maxHeight: Get.height * 0.8,
        minHeight: 400,
        minWidth: 300,
      ),
      child: Dialog(
        shape: shape,
        backgroundColor: Colors.white,
        child: Scrollbar(
          controller: scrollController,
          child: Column(
            children: [
              // Header
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: const Color(0xFF0E9D6D),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ClipRRect(
                      child: Image.asset("assets/back.png", fit: BoxFit.cover),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
              ),
              // Form
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: acheivementFormKey,
                    child: Column(
                      children: [
                        // Session Info
                        CustomContainer(
                          headerText: "latest session info",
                          headerIcon: Icons.person,
                          headreActions: [
                            createSingleLineTag(
                                "memorization", Color(0xFFe7b05d)),
                            createSingleLineTag(
                                "quick revision", Color(0xFF67bae0)),
                            createSingleLineTag(
                                "major revision", Color(0xFF869456)),
                          ],
                          child: Column(
                            children: sessionInfoList.surahAyahList
                                .asMap()
                                .entries
                                .map((e) {
                              return AcheivementBlock(
                                key: ValueKey(e.value.key),
                                surahAyah: e.value,
                                onDelete: null,
                                onSave: null,
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Hifd
                        CustomContainer(
                          headerText: "memorization",
                          headerIcon: Icons.person,
                          headreActions: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  hifdList.addSurahAyah();
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                          child: Column(
                            children:
                                hifdList.surahAyahList.asMap().entries.map((e) {
                              return AcheivementBlock(
                                key: ValueKey(e.value.key),
                                surahAyah: e.value,
                                onDelete: () {
                                  setState(() {
                                    hifdList.removeSurahAyah(e.key);
                                  });
                                },
                                onSave: () {
                                  acheivement.hifd = hifdList.surahAyahList;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Quick Revision
                        CustomContainer(
                          headerText: "quick revision",
                          headerIcon: Icons.person,
                          headreActions: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quickRevList.addSurahAyah();
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                          child: Column(
                            children: quickRevList.surahAyahList
                                .asMap()
                                .entries
                                .map((e) {
                              return AcheivementBlock(
                                key: ValueKey(e.value.key),
                                surahAyah: e.value,
                                onDelete: () {
                                  setState(() {
                                    quickRevList.removeSurahAyah(e.key);
                                  });
                                },
                                onSave: () {
                                  acheivement.quickRev =
                                      quickRevList.surahAyahList;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Major Revision
                        CustomContainer(
                          headerText: "major revision",
                          headerIcon: Icons.person,
                          headreActions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  majorRevList.addSurahAyah();
                                });
                              },
                              child: const Text("add"),
                            ),
                          ],
                          child: Column(
                            children: majorRevList.surahAyahList
                                .asMap()
                                .entries
                                .map((e) {
                              return AcheivementBlock(
                                key: ValueKey(e.value.key),
                                surahAyah: e.value,
                                onDelete: () {
                                  setState(() {
                                    majorRevList.removeSurahAyah(e.key);
                                  });
                                },
                                onSave: () {
                                  acheivement.majorRev =
                                      majorRevList.surahAyahList;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Other
                        CustomContainer(
                          headerText: "other",
                          headerIcon: Icons.question_mark,
                          child: Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  inputTitle: "presence state",
                                  child: DropDownWidget(
                                    items: presenceState,
                                    initialValue: presenceState[0],
                                    onSaved: (p0) =>
                                        acheivement.attendenceStatus = p0 ?? '',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InputField(
                                  inputTitle: "teacher note",
                                  child: TextFormField(
                                    onSaved: (p0) =>
                                        acheivement.teacherNote = p0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Submit button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    isComplete.value = false;

                    acheivement.sessionInfo = sessionInfoList.surahAyahList;
                    acheivement.hifd = hifdList.surahAyahList;
                    acheivement.quickRev = quickRevList.surahAyahList;
                    acheivement.majorRev = majorRevList.surahAyahList;

                    dev.log(acheivement.toMap().toString());

                    await submitForm(
                      acheivementFormKey,
                      connect,
                      acheivement,
                      url,
                      isComplete,
                    );

                    isComplete.value = true;
                  },
                  child: Obx(() => isComplete.value
                      ? const Text("Submit")
                      : const CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget generateSurahAyahTags(List<SurahAyah> content) {
  return Wrap(
    spacing: 3, // space between adjacent chips
    runSpacing: 3, // space between lines of chips
    children: content
        .map((e) => createMultiLineTag(e.fromSurahName!, e.toSurahName!))
        .toList(),
  );
}

Widget createSingleLineTag(String tag, Color color) => Chip(
      label: Text(tag),
      backgroundColor: color,
      labelPadding: EdgeInsets.all(2),
    );

Widget createMultiLineTag(String first, String last) => Chip(
      labelPadding: EdgeInsets.all(2),
      backgroundColor: Color(0xff85945d),
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(first),
          Text(last),
        ],
      ),
    );

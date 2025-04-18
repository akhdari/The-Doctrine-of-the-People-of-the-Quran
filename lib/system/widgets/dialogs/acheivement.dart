import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../drop_down.dart';
import '../../../controllers/submit_form.dart';
import '../../models/post/acheivement.dart';
import '../../services/connect.dart';
import '../custom_container.dart';
import '../input_field.dart';
import '../../utils/const/acheivement.dart';
import '../../models/post/surah_ayah.dart';
import '../../models/post/surah_ayah_list.dart';

const String url = 'http://192.168.100.20/phpscript/get_guardian.php';

class AcheivemtDialog extends StatefulWidget {
  const AcheivemtDialog({super.key});

  @override
  State<AcheivemtDialog> createState() => _AcheivemtDialogState();
}

class _AcheivemtDialogState extends State<AcheivemtDialog> {
  final GlobalKey<FormState> acheivementFormKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  final Connect connect = Connect(); //TODO
  final Acheivement acheivement = Acheivement();
  SurahAyahList dataList = SurahAyahList();

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  BeveledRectangleBorder shape = BeveledRectangleBorder();
  RxBool isComplete = true.obs; //TODO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
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
                //header
                Stack(children: [
                  ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.dstIn),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: const Color(0xFF0E9D6D),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ClipRRect(
                      child: Image.asset(
                        "assets/back.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  )
                ]),

                // Form
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: acheivementFormKey,
                      child: Column(
                        children: [
                          CustomContainer(
                            title: "quick revision",
                            icon: Icons.person,
                            addButton: TextButton(
                                onPressed: () {
                                  setState(() {
                                    dataList.addSurahAyah();
                                  });
                                },
                                child: Text("add")),
                            child: Column(
                                children: dataList.surahAyahList
                                    .asMap()
                                    .entries
                                    .map((e) {
                              return AcheivementBlock(
                                key: ValueKey(e.value
                                    .key), //keyObject ValueKey(UniqueKey key)
                                surahAyah: e.value,
                                onDelete: () {
                                  setState(() {
                                    dataList.removeSurahAyah(e.key);
                                  });
                                },
                              );
                            }).toList()),
                          ),
                          SizedBox(
                            height: 10,
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

                        await submitForm(acheivementFormKey, connect,
                            acheivement, url, isComplete);

                        isComplete.value = true;
                      },
                      child: Obx(() => isComplete.value
                          ? Text('Submit')
                          : CircularProgressIndicator()),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AcheivementBlock extends StatefulWidget {
  final SurahAyah surahAyah;
  final Function()? onDelete;
  const AcheivementBlock(
      {super.key, required this.surahAyah, required this.onDelete});

  @override
  State<AcheivementBlock> createState() => _AcheivementBlockState();
}

class _AcheivementBlockState extends State<AcheivementBlock> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: InputField(
              inputTitle: "from surah",
              child: DropDownWidget(
                items: surah,
                initialValue: null,
                onSaved: (p0) => widget.surahAyah.fromSurahName = p0,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InputField(
              inputTitle: "from ayah",
              child: DropDownWidget(
                items: ayahNumbers,
                initialValue: null,
                onSaved: (p0) => widget.surahAyah.fromAyahNumber = p0,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InputField(
              inputTitle: "to surah",
              child: DropDownWidget(
                items: surah,
                initialValue: null,
                onSaved: (p0) => widget.surahAyah.toSurahName = p0,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InputField(
              inputTitle: "to surah",
              child: DropDownWidget(
                items: ayahNumbers,
                initialValue: null,
                onSaved: (p0) => widget.surahAyah.toAyahNumber = p0,
              )),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: InputField(
              inputTitle: "observation",
              child: DropDownWidget(
                items: surah,
                initialValue: null,
                onSaved: (p0) => widget.surahAyah.observation = p0,
              )),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            widget.onDelete!();
          },
        ),
      ],
    );
  }
}

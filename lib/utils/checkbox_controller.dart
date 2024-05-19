import 'package:get/get.dart';

class CheckBoxController {
  List<RxBool> marked = [];
  RxBool markAll = false.obs;
  RxInt markedCount = 0.obs;

  void setMarks(List<RxBool> marked) {
    this.marked = marked;
  }

  void markItem(int index, bool value) {
    marked[index].value = value;

    if (value) {
      markedCount.value++;
    } else {
      markedCount.value--;
    }
    if (markedCount.value == marked.length)
      markAll.value = true;
    else if (markedCount.value == 0)
      markAll.value = false;
    else
      markAll.value = null;
  }

  void toggleMarkAll() {
    if (markAll.value)
      unmarkAll();
    else
      markAllItems();
  }

  void markAllItems() {
    marked.forEach((element) {
      element.value = true;
    });
    markAll.value = true;
    markedCount.value = marked.length;
  }

  void unmarkAll() {
    marked.forEach((element) {
      element.value = false;
    });
    markAll.value = false;
    markedCount.value = 0;
  }
}

import 'package:demo_b/modules/base/baseModel.dart';
import 'package:demo_b/widgets/selectParticipantTitle.dart';

class SelectParticipantModel extends BaseModel {
  List<SelectParticipantItem> items = [
    // SelectParticipantItem(
    //   title: 'anhduong@gmail.com',
    //   avatar: '',
    //   selected: true,
    // ),
    // SelectParticipantItem(
    //   title: 'bach@gmail.com',
    //   avatar: '',
    //   selected: false,
    // ),
  ];

  void onChangedSelectItem(int index, bool value) {
    items[index].selected = value;
    notifyListeners();
  }
}

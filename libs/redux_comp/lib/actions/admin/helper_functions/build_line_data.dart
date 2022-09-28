import 'package:redux_comp/models/admin/app_metrics/observation_model.dart';

List<ObservationModel> buildData(obj, start, DateTime end, period) {
  int length = obj["Values"].length;

  List<ObservationModel> data = [];
  int i = 0;
  while (start != end.add(Duration(minutes: period)) && i < length) {
    if (start.toString().substring(11, 16) ==
        (obj["Timestamps"][i]).substring(11, 16)) {
      data.add(ObservationModel(
          time: (start.toString().substring(11, 16)), value: obj['Values'][i]));
      i++;
    } else {
      data.add(ObservationModel(time: start.toString().substring(11, 16)));
    }
    start = start.add(Duration(minutes: period));
  }
  return data;
}

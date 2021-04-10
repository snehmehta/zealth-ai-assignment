import 'package:zealth/service/apiHelper.dart';

class Service {
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  Future<void> reportSymptom(Map symptoms) async {
    var data = {"symptoms": symptoms, "user-id": 123};
    var response = await apiBaseHelper.post('', data: data);
    print(response);
  }
}

import 'package:flutter/foundation.dart';
import 'package:zealth/model/symptom.dart';

class SymptomProvider extends ChangeNotifier {
  final List<Symptom> _symptoms = [];

  List<Symptom> get symptoms => _symptoms;

  void add(Symptom symptom) {
    _symptoms.add(symptom);
    notifyListeners();
  }

  void removeAll() {
    _symptoms.clear();
    notifyListeners();
  }
}

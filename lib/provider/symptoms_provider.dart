import 'package:flutter/foundation.dart';
import 'package:zealth/model/symptom.dart';

class SymptomProvider extends ChangeNotifier {
  final Set<Symptom> _symptoms = Set();

  Set<Symptom> get symptoms => _symptoms;

  void add(Symptom symptom) {
    _symptoms.add(symptom);
    notifyListeners();
  }

  void removeAll() {
    _symptoms.clear();
    notifyListeners();
  }
}

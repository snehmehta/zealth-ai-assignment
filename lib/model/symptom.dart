class Symptom {
  final String id;
  final String title;
  final String asset;
  int severity;
  final List<String> conditions;

  Symptom({this.id, this.severity, this.title, this.asset, this.conditions});
}

List<Symptom> mockSymptoms = [
  Symptom(
      id: 'fatigue',
      title: "Fatigue",
      asset: "assets/icons/headache.png",
      conditions: [
        "Able to do most activities",
        "In bed less than 50% of the day",
        "In bed more than 50% of the day",
      ]),
  Symptom(
    id: 'vomiting',
    title: "Vomiting",
    asset: "assets/icons/vomiting.png",
    conditions: [
      "Vomited once during the day",
      "Vomited 2-5 times during the day",
      "Vomited 6 or more times during the day",
    ],
  ),
];

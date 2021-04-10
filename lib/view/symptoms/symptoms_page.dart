import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zealth/model/symptom.dart';
import 'package:zealth/view/symptoms/search_bar.dart';

class SymptomsPage extends StatefulWidget {
  const SymptomsPage({Key key}) : super(key: key);

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  var selectedSymptoms = Set<Symptom>();

  var suggestedSymptoms = mockSymptoms;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(
            'assets/svg/handburger.svg',
            width: 24.0,
            height: 24.0,
          ),
        ),
        title: Text(
          "Symptoms",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SearchBar(
              selectedSymptoms: selectedSymptoms,
            ),
            SizedBox(height: 28.0),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Suggested Symptoms',
                    style: textTheme.bodyText1.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 22.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: suggestedSymptoms.map((symptom) {
                      return SymptomSuggestion(
                        title: symptom.title,
                        icon: Image.asset(
                          symptom.asset,
                          fit: BoxFit.contain,
                        ),
                        onTap: () {
                          setState(() {
                            selectedSymptoms.add(symptom);
                          });
                        },
                      );
                    }).toList()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomSuggestion extends StatelessWidget {
  const SymptomSuggestion({
    Key key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      highlightColor: Color(0xFFF8F8F8),
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 47.0,
              width: 47.0,
              child: icon,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: textTheme.bodyText1.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 8.0)
          ],
        ),
      ),
    );
  }
}

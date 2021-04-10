import 'package:flutter/material.dart';
import 'package:zealth/model/symptom.dart';
import 'package:zealth/view/symptom_detail_page.dart';

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
        leading: Icon(Icons.menu),
        title: Text(
          "Symptoms",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(8.0),
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
                SizedBox(height: 16.0),
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

class SearchBar extends StatelessWidget {
  final Set<Symptom> selectedSymptoms;

  const SearchBar({
    Key key,
    this.selectedSymptoms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search & Add Your Symptoms',
            style: textTheme.headline6,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: selectedSymptoms.isEmpty
                      ? Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(width: 4.0),
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Search Symptoms',
                                hintStyle: textTheme.bodyText1
                                    .copyWith(color: Colors.grey),
                              ),
                            )),
                          ],
                        )
                      : Row(
                          children: selectedSymptoms.map((symptom) {
                            return Row(
                              children: [
                                Image.asset(
                                  symptom.asset,
                                  width: 40.0,
                                  height: 40.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(symptom.title),
                                SizedBox(width: 4.0)
                              ],
                            );
                          }).toList(),
                        ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: selectedSymptoms.isNotEmpty
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SymptomDetail(
                                selectedSymptoms: selectedSymptoms,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text('check'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

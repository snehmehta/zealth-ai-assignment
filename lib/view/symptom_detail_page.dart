import 'package:flutter/material.dart';
import 'package:zealth/model/symptom.dart';

class SymptomDetail extends StatefulWidget {
  final Set<Symptom> selectedSymptoms;

  SymptomDetail({Key key, this.selectedSymptoms}) : super(key: key);

  @override
  _SymptomDetailState createState() => _SymptomDetailState();
}

class _SymptomDetailState extends State<SymptomDetail> {
  int _curr = 0;

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Symptoms",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: widget.selectedSymptoms.length,
              itemBuilder: (context, index) {
                return SymptomsDetailPage(
                  symptom: widget.selectedSymptoms.elementAt(index),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.animateToPage(
                        _curr - 1,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 200),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: Text('⬅ Previous'),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.animateToPage(
                        _curr + 1,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 200),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: Text('Next'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SymptomsDetailPage extends StatelessWidget {
  final Symptom symptom;
  final String groupValue = "severity";

  const SymptomsDetailPage({Key key, this.symptom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.topLeft,
            child: Text(
              'More about ${symptom.title}',
              style: textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: RadioListBuilder(
              conditions: symptom.conditions,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Any medication / Comments",
                  style:
                      textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Comment",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  final List<String> conditions;

  const RadioListBuilder({Key key, this.conditions}) : super(key: key);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int value;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin:
              index == 0 ? const EdgeInsets.symmetric(vertical: 16.0) : null,
          child: RadioListTile(
            value: index,
            groupValue: value,
            onChanged: (ind) => setState(() => value = ind),
            title: Row(
              children: [
                Image.asset(
                  'assets/icons/level${index + 1}.png',
                  width: 30.0,
                  height: 30.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(widget.conditions.elementAt(index)),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.conditions.length,
    );
  }
}

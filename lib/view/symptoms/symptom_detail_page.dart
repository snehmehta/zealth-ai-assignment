import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zealth/model/symptom.dart';
import 'package:zealth/provider/symptoms_provider.dart';
import 'package:zealth/service/service.dart';

import 'components/radio_list_builder.dart';
import 'components/rounded_container.dart';

class SymptomDetail extends StatefulWidget {
  final Set<Symptom> selectedSymptoms;

  SymptomDetail({Key key, this.selectedSymptoms}) : super(key: key);

  @override
  _SymptomDetailState createState() => _SymptomDetailState();
}

class _SymptomDetailState extends State<SymptomDetail> {
  bool isFinal = false;
  int _cur = 1;
  final PageController controller = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_cur == widget.selectedSymptoms.length) {
      setState(() {
        isFinal = true;
      });
    }
  }

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
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFA5B2BE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(18.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_arrow_left),
                        Text('Previous'),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Consumer<SymptomProvider>(
                    builder: (BuildContext context, value, Widget child) {
                      return ElevatedButton(
                        onPressed: () {
                          if (controller.page ==
                              widget.selectedSymptoms.length - 1) {
                            var map = Map.fromIterable(value.symptoms,
                                key: (e) => e.id, value: (e) => e.severity);

                            Service().reportSymptom(map);
                            value.removeAll();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Report sent: ${map.toString()}')),
                            );
                            Navigator.pop(context);
                          } else {
                            controller.nextPage(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF51C185),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.all(18.0),
                        ),
                        child: controller.page ==
                                widget.selectedSymptoms.length - 1
                            ? Text('Update')
                            : Text('Next'),
                      );
                    },
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
          RoundedContainer(
            child: RadioListBuilder(
              symptom: symptom,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          RoundedContainer(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Any medication / Comments",
                    style: textTheme.bodyText1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Comment",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

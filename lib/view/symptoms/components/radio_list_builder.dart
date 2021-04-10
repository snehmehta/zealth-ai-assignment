import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zealth/model/symptom.dart';
import 'package:flutter/material.dart';
import 'package:zealth/provider/symptoms_provider.dart';

class RadioListBuilder extends StatefulWidget {
  final Symptom symptom;

  const RadioListBuilder({Key key, this.symptom}) : super(key: key);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int value;

  @override
  Widget build(BuildContext context) {
    var symptoms = Provider.of<SymptomProvider>(context, listen: true);
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin:
              index == 0 ? const EdgeInsets.symmetric(vertical: 16.0) : null,
          child: RadioListTile(
            activeColor: Colors.orange,
            value: index,
            groupValue: value,
            onChanged: (ind) {
              setState(() => value = ind);
              widget.symptom.severity = ind + 1;
              symptoms.add(widget.symptom);
            },
            title: Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/level${index + 1}.svg',
                  width: 30.0,
                  height: 30.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(widget.symptom.conditions.elementAt(index)),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: widget.symptom.conditions.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zealth/model/symptom.dart';
import 'package:zealth/view/symptoms/symptom_detail_page.dart';

class SearchBar extends StatefulWidget {
  final Set<Symptom> selectedSymptoms;

  const SearchBar({
    Key key,
    this.selectedSymptoms,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
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
                  child: widget.selectedSymptoms.isEmpty
                      ? Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/search.svg',
                              width: 24.0,
                              height: 24.0,
                            ),
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
                          children: widget.selectedSymptoms.map((symptom) {
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
                    primary: Color(0xFFFFE9E4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    shadowColor: Colors.white,
                  ),
                  onPressed: widget.selectedSymptoms.isNotEmpty
                      ? () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SymptomDetail(
                                selectedSymptoms: widget.selectedSymptoms,
                              ),
                            ),
                          );

                          setState(() {
                            widget.selectedSymptoms.clear();
                          });
                        }
                      : null,
                  child: Text(
                    'check',
                    style:
                        textTheme.bodyText1.copyWith(color: Color(0xFFFF0270)),
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

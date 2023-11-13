import 'package:flutter/material.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:hotel_go/Widgets/clipper.dart';
import 'package:hotel_go/Widgets/room.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});
  @override
  State<StatefulWidget> createState() {
    return _FormState();
  }
}

class _FormState extends State<FormWidget> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  String? _selectedCountry;
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedStartDate = DateTime.now();
    _selectedEndDate = DateTime(_selectedStartDate!.year + 1);
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: _selectedStartDate!,
      lastDate: DateTime(_selectedStartDate!.year + 1),
    );

    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked.start;
        _selectedEndDate = picked.end;
        _dateController.text =
            '${_selectedStartDate!.toLocal()} ==> ${_selectedEndDate!.toLocal()}';
      });
    }
  }

  void _roomsAndGuests() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return RoomOverlay();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipBehavior: Clip.hardEdge,
          clipper: BirthDayCardClipper(),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border.all(color: Colors.white),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            height: 70,
            width: 200,
            child: const Text(
              'Hotels Search',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Colors.lightBlue,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.fromLTRB(14, 7, 14, 0),
          child: Form(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Select City',
                      hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ).applyDefaults(Theme.of(context).inputDecorationTheme),
                    validator: (value) {},
                    style: TextStyle(
                        color:
                            Theme.of(context).copyWith().colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                      readOnly: true,
                      onTap: () {
                        _selectDateRange(context);
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Pick a date',
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ).applyDefaults(Theme.of(context).inputDecorationTheme),
                      validator: (value) {},
                      style: TextStyle(
                          color:
                              Theme.of(context).copyWith().colorScheme.primary),
                      controller: _dateController),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: CountryListPick(
                        theme: CountryTheme(
                          isShowFlag: false,
                          isShowCode: false,
                          isShowTitle: true,
                          isDownIcon: true,
                          alphabetSelectedBackgroundColor: Colors.white,
                          searchHintText: 'Select Nationality',
                        ),
                        initialSelection: _selectedCountry,
                        onChanged: (CountryCode? code) {
                          setState(() {
                            _selectedCountry = code!.name;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _roomsAndGuests,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('data'),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(14, 0, 14, 7),
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.orangeAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.search),
            label: const Text('Find Hotels'),
          ),
        ),
      ],
    );
  }
}

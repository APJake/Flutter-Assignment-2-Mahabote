import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/functions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedDate = DateTime(2000);
  var selected = false;
  var dateFormatter = DateFormat("MMM dd, yyyy (EEEE)");
  var myanmarYear = -1;
  var remainder = -1;
  var cbNewYear = false;
  var houseName = "";
  var myanmarYearMM = "";
  var weekDayMM = "";

  void setUpDataToVariables() {
    var mmYear = selectedDate.year - 639;
    if (selectedDate.month > 4) {
      mmYear = selectedDate.year - 638;
    } else if (selectedDate.month == 4 && cbNewYear) {
      mmYear = selectedDate.year - 638;
    }
    myanmarYear = mmYear;
    remainder = myanmarYear % 7;

    myanmarYearMM = toMyanmarNumbers(myanmarYear.toString());
    weekDayMM = getWeekDayMMString(selectedDate.weekday);
  }

  @override
  Widget build(BuildContext context) {
    if (selected) {
      houseName = getHouseResult(remainder, selectedDate.weekday);
      setUpDataToVariables();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("မဟာဘုတ်"),
      ),
      body: _homeDesign(),
    );
  }

  TextStyle _specialTextStyle(isSpecial) => TextStyle(
      color: isSpecial ? Theme.of(context).primaryColor : Colors.black,
      fontWeight: isSpecial ? FontWeight.w800 : FontWeight.normal);

  Padding _mahaboteText(val) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Text(val,
            textAlign: TextAlign.center,
            style: _specialTextStyle(val == houseName)),
      );

  Padding _mahaboteNumberText(val) => Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Text(toMyanmarNumber(val),
            textAlign: TextAlign.center,
            style: _specialTextStyle(val == remainder)),
      );

  Widget _mahaboteLayout() => Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Table(
            border: const TableBorder(
              verticalInside: BorderSide(
                color: Colors.black38,
                width: 1,
              ),
              horizontalInside: BorderSide(
                color: Colors.black38,
                width: 1,
              ),
            ),
            children: [
              TableRow(
                children: [
                  const Text(""),
                  _mahaboteText("အဓိပတိ"),
                  const Text(""),
                ],
              ),
              TableRow(
                children: [
                  _mahaboteText("အထွန်း"),
                  _mahaboteText("သိုက်"),
                  _mahaboteText("ရာဇ"),
                ],
              ),
              TableRow(
                children: [
                  _mahaboteText("မရဏ"),
                  _mahaboteText("ဘင်္ဂ"),
                  _mahaboteText("ပုတိ"),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _topLayout() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (selected)
                  ? "မြန်မာသက္ကရာဇ် - $myanmarYearMM ခုနှစ် ($weekDayMM)"
                  : "မဟာဘုတ်မွေဖွားဇာတာ တွက်ချက်ရန် သင်၏မွေးနေ့ကိုရွေးခြယ်ပေးပါ",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            OutlinedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1800),
                    lastDate: DateTime(2025),
                    helpText: "သင်၏မွေးနေ့ကိုရွေးခြယ်ပါ",
                    cancelText: "မရွေးသေးပါ",
                    confirmText: "ရွေးခြယ်မည်");
                if (picked != null) {
                  setState(() {
                    selected = true;
                    selectedDate = picked;
                  });
                }
              },
              child: Text(
                (selected)
                    ? dateFormatter.format(selectedDate)
                    : "မွေးနေ့ရွေးခြယ်ပါ",
                style: const TextStyle(color: Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
            ),
            (selectedDate.month == 4) ? _newYearCheckBox() : Container()
          ],
        ),
      );

  Widget _newYearCheckBox() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: cbNewYear,
            onChanged: (checked) {
              setState(() {
                cbNewYear = !cbNewYear;
              });
            },
          ),
          const Text(
            "နှစ်သစ်ကူးမှာမွေးပါသလား?",
            style: TextStyle(color: Colors.white),
          ),
        ],
      );

  Widget _resultLayout() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$myanmarYearMM ခုနှစ်မွေး",
              ),
              Text(
                "(အကြွင်း ${toMyanmarNumber(remainder)}) ",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "$weekDayMM သားသည်",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                houseName,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                " ဖွားဖြစ်သည်",
              ),
            ],
          ),
        ],
      );

  Widget _mahaboteNumberLayout(numbers) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${toMyanmarNumber(remainder)} ကြွင်း မဟာဘုတ် ဇာတာ",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Table(
                border: const TableBorder(
                  verticalInside: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                  horizontalInside: BorderSide(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
                children: [
                  TableRow(
                    children: [
                      const Text(""),
                      _mahaboteNumberText(numbers[6]),
                      const Text(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      _mahaboteNumberText(numbers[2]),
                      _mahaboteNumberText(numbers[3]),
                      _mahaboteNumberText(numbers[4]),
                    ],
                  ),
                  TableRow(
                    children: [
                      _mahaboteNumberText(numbers[1]),
                      _mahaboteNumberText(numbers[0]),
                      _mahaboteNumberText(numbers[5]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _homeDesign() => ListView(
        children: <Widget>[
          Container(
            height: 170,
            color: Theme.of(context).primaryColor,
            child: _topLayout(),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Card(
              child: _mahaboteLayout(),
            ),
          ),
          (selected)
              ? Container(
                  height: 160,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Card(
                    child: _resultLayout(),
                  ),
                )
              : Container(),
          (selected)
              ? Container(
                  height: 290,
                  margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Card(
                    child: _mahaboteNumberLayout(getMahaboteNumbers(remainder)),
                  ),
                )
              : Container(),
        ],
      );
}

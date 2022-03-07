const myanmarNumbers = ['၀', '၁', '၂', '၃', '၄', '၅', '၆', '၇', '၈', '၉'];
const houses = ["ဘင်္ဂ", "အထွန်း", "ရာဇ", "အဓိပတိ", "မရဏ", "သိုက်", "ပုတိ"];
const mahaboteNumbers = [1, 4, 0, 3, 6, 2, 5];
const mahaboteMyanmarPoetry = ["အောင်", "လံ", "ထူ", "စစ်", "သူ", "ကြီး", "ပွဲ"];

const weekDays = [
  "တနင်္လာ",
  "အင်္ဂါ",
  "ဗုဒ္ဓဟူး",
  "ကြာသပတေး",
  "သောကြာ",
  "စနေ",
  "တနင်္ဂနွေ"
];

String getHouseResult(year, day) {
  return houses[(year - day - 1) % 7];
}

String toMyanmarNumbers(String text) {
  var converted = "";
  text.split('').forEach((ch) {
    var num = int.tryParse(ch);
    if (num != null) {
      converted += toMyanmarNumber(num);
    } else {
      converted += ch;
    }
  });
  return converted;
}

String toMyanmarNumber(int num) {
  if (num < 0 || num > 9) return num.toString();
  return myanmarNumbers[num];
}

List<String> toMyanmarNumberList(List<int> numbers) =>
    numbers.map((e) => toMyanmarNumber(e)).toList();

String getWeekDayMMString(int weekDay) => weekDays[weekDay - 1];

List<int> getMahaboteNumbers(modVal) {
  var index = mahaboteNumbers.indexOf(modVal);
  var newList = mahaboteNumbers.sublist(index);
  newList.addAll(mahaboteNumbers.sublist(0, index));
  return newList;
}

List<String> getMahaboteMyanmarNumbers(modVal) {
  return toMyanmarNumberList(getMahaboteNumbers(modVal));
}

List<String> getMahabotePoetries(modVal) {
  var index = mahaboteNumbers.indexOf(modVal);
  var newList = mahaboteMyanmarPoetry.sublist(index);
  newList.addAll(mahaboteMyanmarPoetry.sublist(0, index));
  return newList;
}

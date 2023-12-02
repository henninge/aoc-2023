import 'dart:io';

int part1(Iterable<String> calibrations) {
  print(calibrations);
  var pat = RegExp(r'[0-9]');
  var numbers = calibrations.map<int>((line) {
    final first = num.parse(line[line.indexOf(pat)]).toInt();
    final last = num.parse(line[line.lastIndexOf(pat)]).toInt();
    return first * 10 + last;
  });
  return numbers.reduce((value, element) => value + element);
}

final numbers = [
  "zero",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
];

// NOT correct: eightwo -> 8wo
int part2(Iterable<String> calibrations) {
  final pat = RegExp(numbers.join("|"));
  return part1(calibrations.map<String>((line) {
    String newLine = line;
    do {
      line = newLine;
      newLine = line.replaceFirstMapped(pat, (match) {
        return numbers.indexOf(match.group(0)!).toString();
      });
    } while (line != newLine);
    return line;
  }));
}

// Correct: eightwo -> 8igh2wo
int part2a(Iterable<String> calibrations) {
  final pat = RegExp(numbers.join("|"));
  return part1(calibrations.map<String>((line) {
    final newLine = StringBuffer();
    for (var i = 0; i < line.length; i++) {
      final match = pat.matchAsPrefix(line, i);
      if (match == null) {
        newLine.write(line[i]);
      } else {
        newLine.write(numbers.indexOf(match.group(0)!).toString());
      }
    }
    return newLine.toString();
  }));
}

List<String> readFile(String filename) {
  var file = File(filename);
  return file.readAsLinesSync();
}

void main() {
  var calibrations = readFile('01/demo2.txt');
  var result = part2a(calibrations);
  print('Result: ${result}');
}

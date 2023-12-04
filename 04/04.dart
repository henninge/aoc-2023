import 'dart:io';
import 'dart:math';

final linePat = RegExp(r'^Card .+: (?<winning>.+) \| (?<have>.+)$');

Set<int> makeSet(String numString) {
  return numString.trim().split(RegExp(r' +')).map((e) => int.parse(e)).toSet();
}

int findMatches(line) {
  final match = linePat.firstMatch(line);
  final winning = makeSet(match!.namedGroup('winning')!);
  final have = makeSet(match.namedGroup('have')!);
  return winning.intersection(have).length;
}

int part1(Iterable<String> lines) {
  return lines.fold<int>(0, (sum, line) {
    final matches = findMatches(line);
    if (matches == 0) return sum;
    return sum + pow(2, matches - 1).toInt();
  });
}

int part2(Iterable<String> lines) {
  final matches = lines.map<int>(findMatches).toList();
  final counts = List<int>.filled(lines.length, 1);
  // m: match
  // w: won
  for (var m = 0; m < lines.length; m++) {
    for (var w = m + 1; w <= m + matches[m]; w++) {
      counts[w] += counts[m];
    }
  }
  return counts.fold(0, (sum, value) => sum + value);
}

Iterable<String> readFile(String filename) {
  var file = File(filename);
  return file.readAsLinesSync();
}

void main() {
  var lines = readFile('04/input.txt');
  var result = part1(lines.toList());
  print('Result: ${result}');
  result = part2(lines);
  print('Result: ${result}');
}

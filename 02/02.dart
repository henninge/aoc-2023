import 'dart:io';

class Set {
  int blue = 0;
  int green = 0;
  int red = 0;

  Set(this.blue, this.green, this.red);

  Set.parse(String line) {
    final pat = RegExp(r'(?<count>[0-9]+) (?<color>red|blue|green)');
    for (final cubeInfo in line.split(',')) {
      final match = pat.firstMatch(cubeInfo)!;
      final count = int.parse(match.namedGroup('count')!);
      switch (match.namedGroup('color')!) {
        case 'blue':
          blue = count;
        case 'green':
          green = count;
        case 'red':
          red = count;
      }
    }
  }

  bool fits(Set limit) {
    return blue <= limit.blue && green <= limit.green && red <= limit.red;
  }

  int get power => blue * green * red;
}

int max(int left, int right) {
  return left > right ? left : right;
}

Set maxSet(Set left, Set right) {
  return Set(
    max(left.blue, right.blue),
    max(left.green, right.green),
    max(left.red, right.red),
  );
}

Set getMaxSet(String sets) {
  return sets.split('; ').map<Set>(Set.parse).reduce(maxSet);
}

Set getMinSet(String sets) {
  return sets.split('; ').map<Set>(Set.parse).fold(Set(0, 0, 0), maxSet);
}

int part1(List<String> games, Set limit) {
  var sum = 0;
  for (var i = 0; i < games.length; i++) {
    if (getMaxSet(games[i]).fits(limit)) {
      sum += i + 1;
    }
  }
  return sum;
}

int part2(Iterable<String> games) {
  return games.fold<int>(0, (sum, game) => sum + getMinSet(game).power);
}

Iterable<String> readFile(String filename) {
  var file = File(filename);
  return file.readAsLinesSync().map((line) => line.split(': ')[1]);
}

void main() {
  var games = readFile('02/input.txt');
  var result = part1(games.toList(), Set(14, 13, 12));
  print('Result: ${result}');
  result = part2(games);
  print('Result: ${result}');
}

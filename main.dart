//21k-3279
//SMD A1

import 'dart:io';

main() {
  Solution obj = new Solution();
  obj.analyzeFile();
  obj.calculateLineWithHighestFrequency();
  obj.printHighestWordFrequencyAcrossLines();
}

class Solution {
  final Map<List<String>, int> wordFrequency = {};
  final Map<List<String>, int> index = {};
  final File file = File('text.txt');

  void analyzeFile() {
    final lines = file.readAsLinesSync();

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final high_freq_words = getMostFrequentWords(line);
      final max = high_freq_words.values.first;
      final words = high_freq_words.keys.toList();

      wordFrequency[words] = max;
      index[words] = i + 1;
    }
  }

  void calculateLineWithHighestFrequency() {
    final overall_max = getmax(wordFrequency);
    print('\nThe lines with the greatest highest frequency words are:');
    printmaxWords(wordFrequency, index, overall_max);
  }

  void printHighestWordFrequencyAcrossLines() {
    print('The following words have the highest frequency per line:');
    printWordOccurrences(wordFrequency, index);
  }

  Map<String, int> getMostFrequentWords(String text) {
    final words = text.split(' ');
    final frequencyMap = <String, int>{};

    for (final word in words) {
      frequencyMap[word] = (frequencyMap[word] ?? 0) + 1;
    }

    final max = frequencyMap.values.reduce((a, b) => a > b ? a : b);
    return { for (var entry in frequencyMap.entries.where((e) => e.value == max)) entry.key : entry.value };
  }

  int getmax(Map<List<String>, int> frequencyMap) {
    return frequencyMap.values.reduce((a, b) => a > b ? a : b);
  }

  void printWordOccurrences(Map<List<String>, int> wordFrequency, Map<List<String>, int> line_map) {
    for (final entry in wordFrequency.entries) {
      final words = entry.key;
      final line_no = line_map[words]!;
      print('$words (appears in line #$line_no)');
    }
  }

  void printmaxWords(Map<List<String>, int> wordFrequency, Map<List<String>, int> line_map, int max) {
    for (final entry in wordFrequency.entries) {
      if (entry.value == max) {
        final words = entry.key;
        final line_no = line_map[words]!;
        print('$words (appears in line #$line_no)');
      }
    }
  }
}
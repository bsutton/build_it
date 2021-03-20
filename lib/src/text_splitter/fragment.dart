part of '../text_splitter.dart';

class Fragment {
  int end;

  int start;

  String text;

  Fragment(this.start, this.end, [this.text = '']) {
    RangeError.checkValueInInterval(start, 0, end, 'start');
  }

  String asString() => text;

  @override
  String toString() {
    return '($start-$end)';
  }
}

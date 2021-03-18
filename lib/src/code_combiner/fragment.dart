part of '../code_combiner.dart';

class _Fragment extends Fragment {
  final String text;

  _Fragment(int start, int end, this.text) : super(start, end);

  @override
  String asString() => text;
}

part of '../code_combiner.dart';

class DirectiveVisitor extends RecursiveAstVisitor {
  final List<Directive> directives;

  DirectiveVisitor(this.directives);

  @override
  void visitExportDirective(ExportDirective node) {
    directives.add(node);
  }

  @override
  void visitImportDirective(ImportDirective node) {
    directives.add(node);
  }

  @override
  void visitPartDirective(PartDirective node) {
    directives.add(node);
  }

  @override
  void visitPartOfDirective(PartOfDirective node) {
    directives.add(node);
  }
}

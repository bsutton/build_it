part of '../code_combiner.dart';

class AnnotationVisitor extends RecursiveAstVisitor {
  final List<Annotation> annotations;

  AnnotationVisitor(this.annotations);

  @override
  void visitAnnotation(Annotation node) {
    annotations.add(node);
  }
}

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

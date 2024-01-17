enum VisitorType {
  single('Single'),
  multi('Multi');

  final String type;

  const VisitorType(this.type);
}

enum StatusVisitor {
  completed('Completed'),
  nonCompleted('Not Completed');

  final String status;

  const StatusVisitor(this.status);
}

enum StatusJob {
  completed('Completed'),
  nonCompleted('Not Completed');

  final String status;

  const StatusJob(this.status);
}

enum StatusColor {
  success,
  notSuccess;
}

class PFilterData {
  final String propertyName;
  dynamic propertyTypeId;
  dynamic emirateId;
  dynamic categoryId;

  PFilterData(
    this.propertyName,
    this.propertyTypeId,
    this.emirateId,
    this.categoryId,
  );
}

class ReportFilterData {
  dynamic propertyTypeId;
  dynamic emirateId;
  final String fromDate;
  final String toDate;

  ReportFilterData(
    this.propertyTypeId,
    this.emirateId,
    this.fromDate,
    this.toDate,
  );
}

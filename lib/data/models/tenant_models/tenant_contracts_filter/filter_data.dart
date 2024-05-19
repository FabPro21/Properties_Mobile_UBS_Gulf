class FilterData {
  final String propertyName;
  dynamic propertyTypeId;
  dynamic contractStatusId;
  final String fromDate;
  final String toDate;

  FilterData(this.propertyName, this.propertyTypeId, this.contractStatusId,
      this.fromDate, this.toDate);
}

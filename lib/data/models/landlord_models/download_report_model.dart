class DownloadReportModel {
  FilePath filePath;
  String message;

  DownloadReportModel({this.filePath, this.message});

  DownloadReportModel.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'] != null
        ? new FilePath.fromJson(json['filePath'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filePath != null) {
      data['filePath'] = this.filePath.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class FilePath {
  String result;
  int id;
  dynamic exception;
  int status;
  bool isCanceled;
  bool isCompleted;
  bool isCompletedSuccessfully;
  int creationOptions;
  dynamic asyncState;
  bool isFaulted;

  FilePath(
      {this.result,
      this.id,
      this.exception,
      this.status,
      this.isCanceled,
      this.isCompleted,
      this.isCompletedSuccessfully,
      this.creationOptions,
      this.asyncState,
      this.isFaulted});

  FilePath.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    id = json['id'];
    exception = json['exception'];
    status = json['status'];
    isCanceled = json['isCanceled'];
    isCompleted = json['isCompleted'];
    isCompletedSuccessfully = json['isCompletedSuccessfully'];
    creationOptions = json['creationOptions'];
    asyncState = json['asyncState'];
    isFaulted = json['isFaulted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['id'] = this.id;
    data['exception'] = this.exception;
    data['status'] = this.status;
    data['isCanceled'] = this.isCanceled;
    data['isCompleted'] = this.isCompleted;
    data['isCompletedSuccessfully'] = this.isCompletedSuccessfully;
    data['creationOptions'] = this.creationOptions;
    data['asyncState'] = this.asyncState;
    data['isFaulted'] = this.isFaulted;
    return data;
  }
}

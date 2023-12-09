
class User{
  late int id;
  late int majorId;
  late int schoolId;
  late int secondMajorId;
  late int coreCourseId;
  late int requiredCourseId;
  late int selectiveCourseId;
  late int selectiveCredit;
  late int secondRequiredCourseId;
  late int secondSelectiveCourseId;
  late int secondSelectiveCourseCredit;
  late String username;
  late String name;
  late String major;
  late String secondMajor;

  User(Map<String, dynamic> userData){
    id = userData['id'];
    majorId = userData['majorId'];
    schoolId = userData['schoolId'];
    coreCourseId = userData['coreCourseId'];
    requiredCourseId = userData['requiredCourseId'];
    selectiveCourseId = userData['selectiveCourseId'];
    selectiveCredit = userData['selectiveCredit'];
    username = userData['username'];
    name = userData['name'];
    major = userData['majorName'];

    if(userData['secondMajorId'] != 0){
      secondMajor = userData['secondMajorName'];
      secondMajorId = userData['secondMajorId'];
      secondRequiredCourseId = userData['secondRequiredCourseId'];
      secondSelectiveCourseId = userData['secondSelectiveCourseId'];
      secondSelectiveCourseCredit = userData['secondSelectiveCourseCredit'];
    } else{
      secondMajorId = 0;
      secondMajor = "";
      secondRequiredCourseId = 0;
      secondSelectiveCourseId = 0;
      secondSelectiveCourseCredit = 0;
    }
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'majorId' : majorId,
    'secondMajorId' : secondMajorId,
    'schoolId' : schoolId,
    'coreCourseId' : coreCourseId,
    'requiredCourseId' : requiredCourseId,
    'selectiveCourseId' : selectiveCourseId,
    'username' : username,
    'name' : name,
    'majorName' : major,
    'secondMajorName' : secondMajor,
    'secondRequiredCourseId' : secondRequiredCourseId,
    'secondSelectiveCourseId' : secondSelectiveCourseId,
    'secondSelectiveCourseCredit' : secondSelectiveCourseCredit
  };

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        majorId = json['majorId'],
        secondMajorId = json['secondMajorId'],
        schoolId = json["schoolId"],
        coreCourseId = json["coreCourseId"],
        requiredCourseId = json["requiredCourseId"],
        selectiveCourseId = json["selectiveCourseId"],
        username = json["username"],
        name = json["name"],
        major = json["majorName"],
        secondMajor = json["secondMajorName"],
        secondRequiredCourseId = json["secondRequiredCourseId"],
        secondSelectiveCourseId = json["secondSelectiveCourseId"],
        secondSelectiveCourseCredit = json ["secondSelectiveCourseCredit"];

}
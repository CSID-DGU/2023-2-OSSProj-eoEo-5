// user 정보를 스프링 부트 프로젝트에 전송해서 DB에 저장
class User {
  final String? name;
  final String? major;
  final String? doublemajor;
  final String? gender;

  // 생성자
  User({required this.name, required this.major, required this.doublemajor ,required this.gender});

  // JSON을 User 객체로 반환하는 factory method
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        major: json['major'],
        doublemajor: json['doublemajor'],
        gender: json['gender']);
  }

  // USER 객체를 JSON 데이터로 변환하는 method
  Map<String, dynamic> toJson() => {
    'name': name,
    'major': major,
    'doublemajor': doublemajor,
    'gender': gender,
  };
}
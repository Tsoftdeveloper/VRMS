class User {
  final String username;
  final String password;
  final String email;
  final String fullname;
  final String cnic;
  final String city;
  final String contact;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.fullname,
    required this.cnic,
    required this.city,
    required this.contact
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['Username'],
      password: json['Password'],
      email: json['User_Email'],
      fullname: json['Full_Name'],
      cnic: json['CNIC_Number'],
      city: json['City'],
      contact: json['Contact_Number'],
    );
  }

  Map<String, dynamic> toJson() => {
    'Username' : username,
    'Password': password,
    'User_Email': email,
    'Full_Name': fullname,
    'CNIC_Number' : cnic,
    'City' : city,
    'Contact_Number' : contact,
  };
}

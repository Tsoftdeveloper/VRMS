import 'dart:collection';

class Mechanic {
  var id;
  var username;
  var password;
  var m_email;
  var fullname;
  var cnic;
  var city;
  var phone;
  var services;
  Mechanic();

  String getUsername(String id) {
    if (id == "1") {
      Map mechuser1 = {
        "id": "1",
        "email": "tylerchane@yahoo.com",
        "fullname": "Tyler Chane",
        "city": "Karachi",
        "cell": "03009283676",
        "services":
            "Repair, Petrol Service, Puncture Services, Vehicle inspection, Engine oil, tuning, Tyre rotation and Filter replacement.",
        "rating": "4.5",
        "image": "https://xsgames.co/randomusers/assets/avatars/male/74.jpg",
      };
      return mechuser1["fullname"];
    } else if (id == "2") {
      Map mechuser2 = {
        "id": "2",
        "email": "chris@gmail.com",
        "fullname": "Chris Bale",
        "city": "Islamabad",
        "cell": "03009283676",
        "services":
            "Repair, Oil Monitoring, Engine Fix, Petrol Service, Puncture Services, Vehicle inspection",
        "rating": "3.5",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ-YIPLhIBLVQKh_S4BNo18b03Ct5P_iYFeBBjDCYx&s",
      };

      return mechuser2["fullname"];
    } else if (id == "3") {
      Map mechuser3 = {
        "id": "3",
        "email": "danny@gmail.com",
        "fullname": "Danny",
        "city": "Karachi",
        "cell": "03009283676",
        "services":
            "Petrol Service,Repair, Puncture Services, Vehicle inspection, Engine oil, tuning, Tyre rotation and Filter replacement.",
        "rating": "4.5",
        "image":
            "https://preview.keenthemes.com/metronic-v4/theme/assets/pages/media/profile/profile_user.jpg",
      };
      return mechuser3["fullname"];
    }
    return "";
  }

  Mechanic.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["Username"],
        password = json["Password"],
        m_email = json["Mechanic_Email"],
        fullname = json["Full_Name"],
        cnic = json["CNIC_Number"],
        city = json["City"],
        phone = json["Contact_Number"],
        services = json["Services"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Username": username,
      "Password": password,
      "Mechanic_Email": m_email,
      "Full_Name": fullname,
      "CNIC_Number": cnic,
      "City": city,
      "Contact_Number": phone,
      "Services": services
    };
  }
}

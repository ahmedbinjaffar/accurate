// ignore_for_file: camel_case_types, non_constant_identifier_names

class Technical_Support_Model {
  final String socialmediaicon;
  final String socialname;
  final String linkii;
  Technical_Support_Model(
      {required this.socialmediaicon,
      required this.socialname,
      required this.linkii});
}

var technical_support_model = [
  Technical_Support_Model(
      socialmediaicon: "assets/images/phone (1).png",
      socialname: "Techinal Support One",
      linkii: 'tel:+923196541112'),
  Technical_Support_Model(
      socialmediaicon: "assets/images/phone (1).png",
      socialname: "Techinal Support two",
      linkii: 'tel:+923003086309'),
  Technical_Support_Model(
      socialmediaicon: "assets/images/whatsapp (1).png",
      socialname: "Whatsapp Support",
      linkii: 'https://wa.me/+923133583971'),
];

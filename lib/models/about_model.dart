
class AboutResponseModelAddress {
/*
{
  "address": " ",
  "email": "Info@sellthedwell.com",
  "email2": "Support@sellthedwell.com",
  "phone": null,
  "phone2": null
} 
*/

  String? address;
  String? email;
  String? email2;
  String? phone;
  String? phone2;

  AboutResponseModelAddress({
    this.address,
    this.email,
    this.email2,
    this.phone,
    this.phone2,
  });
  AboutResponseModelAddress.fromJson(Map<String, dynamic> json) {
    address = json['address']?.toString();
    email = json['email']?.toString();
    email2 = json['email2']?.toString();
    phone = json['phone']?.toString();
    phone2 = json['phone2']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address'] = address;
    data['email'] = email;
    data['email2'] = email2;
    data['phone'] = phone;
    data['phone2'] = phone2;
    return data;
  }
}

class AboutResponseModelAbout {
/*
{
  "id": 1,
  "header": "On our platform you're showing your property in real time! Your listing isn't just sitting in cyberspace on one of the many similar looking real estate sites! Sell The Dwell acts as a real engagement tool with prospective buyers, renters and businesses!",
  "sub_header": "It’s a new decade of cyber customers, you should be using online video marketing to boost your advertising. This platform separates top producers from the average ones in that this targets your local buyers, renters and businesses in real time.",
  "youtube_link": "https://www.youtube.com/watch?v=kBTOjIAxqPQ",
  "header_2": "Plenty Of Reasons To Collaborate With Us...",
  "sub_header_2": "Putting the work in to do these active open houses is your job. Putting the work in to gather these leads is our job. We can be successful together. This new economy is about business supporting business, working together to create cross promotion for financial prosperity.",
  "box_1_header": "We are an Enterprise Marketing firm that does Real Time Interactive Management (RTIM)",
  "box_1_content": "Engaging content is what will keep the attention of your customer. Social media ads like Facebook, Twitter and Instagram could be profitable but think about this; “According to a study by Microsoft, the average human being now has an attention span of eight seconds.” People do not have enough patience to read through your content before hoping back to their feed. What that tells me is that you need to diversify your marketing portfolio.",
  "box_2_header": "Awesome Networking Experiences",
  "box_2_content": "This is a true partnership, we require your participation with active open houses to keep this site a lead creator for your business or investment. Work together with others, coordinate with the scheduled open houses in your area or contact other members and create a joint event, make it a community business effort to support each other!",
  "box_3_header": "Ease of Use With Amazing Technology",
  "box_3_content": "They’ll discover a place they’ll love to live, rent or have a creative business space. Its so easy to use, manage and schedule your live tours. Google maps brings any active tour right to anyone using our App with their smartphone or tablet. Drive by open houses are back with the most up to date GPS technology out there!",
  "box_4_header": "Awesome Membership Options",
  "box_4_content": "We offer great incentives like our monthly non-profit social giving program, feature profiles and free 30 day membership momentum for up to 4 properties plus FREE advertising on our YouTube channel. Content to help increase your investment and business! Let's open the door together -Try Sell The Dwell Today.!"
} 
*/

  int? id;
  String? header;
  String? subHeader;
  String? youtubeLink;
  String? header_2;
  String? subHeader_2;
  String? box_1Header;
  String? box_1Content;
  String? box_2Header;
  String? box_2Content;
  String? box_3Header;
  String? box_3Content;
  String? box_4Header;
  String? box_4Content;

  AboutResponseModelAbout({
    this.id,
    this.header,
    this.subHeader,
    this.youtubeLink,
    this.header_2,
    this.subHeader_2,
    this.box_1Header,
    this.box_1Content,
    this.box_2Header,
    this.box_2Content,
    this.box_3Header,
    this.box_3Content,
    this.box_4Header,
    this.box_4Content,
  });
  AboutResponseModelAbout.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    header = json['header']?.toString();
    subHeader = json['sub_header']?.toString();
    youtubeLink = json['youtube_link']?.toString();
    header_2 = json['header_2']?.toString();
    subHeader_2 = json['sub_header_2']?.toString();
    box_1Header = json['box_1_header']?.toString();
    box_1Content = json['box_1_content']?.toString();
    box_2Header = json['box_2_header']?.toString();
    box_2Content = json['box_2_content']?.toString();
    box_3Header = json['box_3_header']?.toString();
    box_3Content = json['box_3_content']?.toString();
    box_4Header = json['box_4_header']?.toString();
    box_4Content = json['box_4_content']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['header'] = header;
    data['sub_header'] = subHeader;
    data['youtube_link'] = youtubeLink;
    data['header_2'] = header_2;
    data['sub_header_2'] = subHeader_2;
    data['box_1_header'] = box_1Header;
    data['box_1_content'] = box_1Content;
    data['box_2_header'] = box_2Header;
    data['box_2_content'] = box_2Content;
    data['box_3_header'] = box_3Header;
    data['box_3_content'] = box_3Content;
    data['box_4_header'] = box_4Header;
    data['box_4_content'] = box_4Content;
    return data;
  }
}

class AboutResponseModel {
/*
{
  "about": {
    "id": 1,
    "header": "On our platform you're showing your property in real time! Your listing isn't just sitting in cyberspace on one of the many similar looking real estate sites! Sell The Dwell acts as a real engagement tool with prospective buyers, renters and businesses!",
    "sub_header": "It’s a new decade of cyber customers, you should be using online video marketing to boost your advertising. This platform separates top producers from the average ones in that this targets your local buyers, renters and businesses in real time.",
    "youtube_link": "https://www.youtube.com/watch?v=kBTOjIAxqPQ",
    "header_2": "Plenty Of Reasons To Collaborate With Us...",
    "sub_header_2": "Putting the work in to do these active open houses is your job. Putting the work in to gather these leads is our job. We can be successful together. This new economy is about business supporting business, working together to create cross promotion for financial prosperity.",
    "box_1_header": "We are an Enterprise Marketing firm that does Real Time Interactive Management (RTIM)",
    "box_1_content": "Engaging content is what will keep the attention of your customer. Social media ads like Facebook, Twitter and Instagram could be profitable but think about this; “According to a study by Microsoft, the average human being now has an attention span of eight seconds.” People do not have enough patience to read through your content before hoping back to their feed. What that tells me is that you need to diversify your marketing portfolio.",
    "box_2_header": "Awesome Networking Experiences",
    "box_2_content": "This is a true partnership, we require your participation with active open houses to keep this site a lead creator for your business or investment. Work together with others, coordinate with the scheduled open houses in your area or contact other members and create a joint event, make it a community business effort to support each other!",
    "box_3_header": "Ease of Use With Amazing Technology",
    "box_3_content": "They’ll discover a place they’ll love to live, rent or have a creative business space. Its so easy to use, manage and schedule your live tours. Google maps brings any active tour right to anyone using our App with their smartphone or tablet. Drive by open houses are back with the most up to date GPS technology out there!",
    "box_4_header": "Awesome Membership Options",
    "box_4_content": "We offer great incentives like our monthly non-profit social giving program, feature profiles and free 30 day membership momentum for up to 4 properties plus FREE advertising on our YouTube channel. Content to help increase your investment and business! Let's open the door together -Try Sell The Dwell Today.!"
  },
  "address": {
    "address": " ",
    "email": "Info@sellthedwell.com",
    "email2": "Support@sellthedwell.com",
    "phone": null,
    "phone2": null
  }
} 
*/

  AboutResponseModelAbout? about;
  AboutResponseModelAddress? address;

  AboutResponseModel({
    this.about,
    this.address,
  });
  AboutResponseModel.fromJson(Map<String, dynamic> json) {
    about = (json['about'] != null) ? AboutResponseModelAbout.fromJson(json['about']) : null;
    address = (json['address'] != null) ? AboutResponseModelAddress.fromJson(json['address']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (about != null) {
      data['about'] = about!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

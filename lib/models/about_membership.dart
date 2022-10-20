
class AboutMembershipResponse {
/*
{
  "id": 1,
  "header": "Get Ready To Be A Part Of A New Interactive Innovative Open House Experience!",
  "sub_line_1": "<p><strong>What We Require From You As A Member Is Hosting Online Active Open Houses On Our App &amp; Website</strong></p>\r\n\r\n<ul>\r\n\t<li>\r\n\t<p>Our Free and Low Cost Monthly&nbsp;Options:</p>\r\n\r\n\t<ul>\r\n\t\t<li>\r\n\t\t<p>1st Month Free: Schedule 4&nbsp;active open houses online with unlimited access to peer to peer video call anytime through our app plus get access to our YouTube channel for more Free exposure</p>\r\n\t\t</li>\r\n\t\t<li>\r\n\t\t<p>Popular: Try it Again! Schedule 4&nbsp;active open houses and have unlimited access to peer to peer video call&nbsp;anytime through our app</p>\r\n\t\t</li>\r\n\t\t<li>\r\n\t\t<p>Professional: 8&nbsp;active open houses online with unlimited access to peer to peer video call anytime through our app&nbsp;with a&nbsp;featured open house on our home page</p>\r\n\t\t</li>\r\n\t\t<li>\r\n\t\t<p>Custom monthly packages for your account is available for additional scheduled open houses</p>\r\n\t\t</li>\r\n\t</ul>\r\n\t</li>\r\n\t<li>\r\n\t<p>Depending on the plan you choose you are required to run active live open houses for public viewing.&nbsp;This can be a digital open house online or a physical open house on property through our website and app. Additionally you have the option to schedule private open house showings with the public connections you connect with through our app as many times as your membership allows. You are your own administrator as a member you control your listings. Receive a live tracking system on our platform making it easy to view your leads and to schedule your appointments. We will offer renewals if content is there for viewing.&nbsp;</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>A portion of every member&#39;s fee will go&nbsp;to our non-profit of the month. Social Giving is part of our culture.</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>We welcome you to add to our Community Advise Page as long as it is relevant, factual real estate information that helps all users.&nbsp;This is for education only not for personal advertising, personal views or unfactual data. Sell The Dwell reserves the right to delete the post and remove access from&nbsp;the member if post does not follow the rules.</p>\r\n\t</li>\r\n\t<li>\r\n\t<p>Check out all the cool ways buyers, renters and businesses can use our functions on our About Us and Home Pages to find you!</p>\r\n\t</li>\r\n</ul>\r\n\r\n<p><strong>Help us by adding your content to our website so we can help you sale or rent your property today!</strong></p>\r\n\r\n<p><strong>We want you to be as successful as possible with our platform!&nbsp;If you have any other questions please contact us we are here for you!</strong></p>",
  "sub_line_2": " ",
  "sub_line_3": " ",
  "sub_line_4": " ",
  "sub_line_5": " ",
  "header_2": " ",
  "sub_header_2": " ",
  "box_1_header": null,
  "box_1_content": null,
  "box_2_header": null,
  "box_2_content": null,
  "box_3_header": null,
  "box_3_content": null,
  "box_4_header": null,
  "box_4_content": null,
  "packages_header": "Choose the Membership plan that works for you",
  "packages_text": "Flexible pricing options to suit your open house business"
} 
*/

  int? id;
  String? header;
  String? subLine_1;
  String? subLine_2;
  String? subLine_3;
  String? subLine_4;
  String? subLine_5;
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
  String? packagesHeader;
  String? packagesText;

  AboutMembershipResponse({
    this.id,
    this.header,
    this.subLine_1,
    this.subLine_2,
    this.subLine_3,
    this.subLine_4,
    this.subLine_5,
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
    this.packagesHeader,
    this.packagesText,
  });
  AboutMembershipResponse.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    header = json['header']?.toString();
    subLine_1 = json['sub_line_1']?.toString();
    subLine_2 = json['sub_line_2']?.toString();
    subLine_3 = json['sub_line_3']?.toString();
    subLine_4 = json['sub_line_4']?.toString();
    subLine_5 = json['sub_line_5']?.toString();
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
    packagesHeader = json['packages_header']?.toString();
    packagesText = json['packages_text']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['header'] = header;
    data['sub_line_1'] = subLine_1;
    data['sub_line_2'] = subLine_2;
    data['sub_line_3'] = subLine_3;
    data['sub_line_4'] = subLine_4;
    data['sub_line_5'] = subLine_5;
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
    data['packages_header'] = packagesHeader;
    data['packages_text'] = packagesText;
    return data;
  }
}

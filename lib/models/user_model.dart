class UserModel {
  String id;
  String customerCode;
  String user;
  String pass;
  String level;
  String type;
  String name;
  String address;
  String province;
  String zipcode;
  String phone;
  String email;
  String cart;
  String status;
  String proId;
  String telecart;
  String contactPerson;
  String idcart;
  String payment;
  String area;
  String note;
  String licenseID;
  String licenseType;
  String number;
  String discount;
  String financialAmount;
  String cartJson;
  String lineID;
  String facebook;

  UserModel(
      {this.id,
      this.customerCode,
      this.user,
      this.pass,
      this.level,
      this.type,
      this.name,
      this.address,
      this.province,
      this.zipcode,
      this.phone,
      this.email,
      this.cart,
      this.status,
      this.proId,
      this.telecart,
      this.contactPerson,
      this.idcart,
      this.payment,
      this.area,
      this.note,
      this.licenseID,
      this.licenseType,
      this.number,
      this.discount,
      this.financialAmount,
      this.cartJson,
      this.lineID,
      this.facebook});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerCode = json['customer_code'];
    user = json['user'];
    pass = json['pass'];
    level = json['level'];
    type = json['type'];
    name = json['name'];
    address = json['address'];
    province = json['province'];
    zipcode = json['zipcode'];
    phone = json['phone'];
    email = json['email'];
    cart = json['cart'];
    status = json['status'];
    proId = json['pro_id'];
    telecart = json['telecart'];
    contactPerson = json['contact_person'];
    idcart = json['idcart'];
    payment = json['payment'];
    area = json['area'];
    note = json['note'];
    licenseID = json['licenseID'];
    licenseType = json['licenseType'];
    number = json['number'];
    discount = json['discount'];
    financialAmount = json['financial_amount'];
    cartJson = json['cart_json'];
    lineID = json['lineID'];
    facebook = json['facebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_code'] = this.customerCode;
    data['user'] = this.user;
    data['pass'] = this.pass;
    data['level'] = this.level;
    data['type'] = this.type;
    data['name'] = this.name;
    data['address'] = this.address;
    data['province'] = this.province;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['cart'] = this.cart;
    data['status'] = this.status;
    data['pro_id'] = this.proId;
    data['telecart'] = this.telecart;
    data['contact_person'] = this.contactPerson;
    data['idcart'] = this.idcart;
    data['payment'] = this.payment;
    data['area'] = this.area;
    data['note'] = this.note;
    data['licenseID'] = this.licenseID;
    data['licenseType'] = this.licenseType;
    data['number'] = this.number;
    data['discount'] = this.discount;
    data['financial_amount'] = this.financialAmount;
    data['cart_json'] = this.cartJson;
    data['lineID'] = this.lineID;
    data['facebook'] = this.facebook;
    return data;
  }
}

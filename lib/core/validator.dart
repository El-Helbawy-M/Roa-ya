import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/localization.dart';

class Validator {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('ادخل البريد الإكتروني بشكل صحيح');
    }
  });
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 2) {
      sink.add(name);
    } else {
      sink.addError('ادخل الاسم بشكل صحيح');
    }
  });

  var number =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length > 9) {
      sink.add(num);
    } else {
      sink.addError('يجب ان يكون رقم الجوال من 10 خانات');
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('يجب ان لا تقل كلمة المرور عن 8 خانات');
    }
  });

  var confirmPassWordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('تأكيد كلمة المرور خاطئ');
    }
  });
}


class EmailValidator {
  static String? emailValidator(String? email) {
    if ( !email!.contains("@") || !email.contains(".com")) {
      return getLang("please_enter_valid_email");
    }
    return null ;
  }
}

class PasswordValidator {
  static String? passwordValidator(var password) {
    if (password!.length < 8) {
      return getLang("password_length_validation");
    }
    return null;
  }
}

class PasswordConfirmationValidator {
  static String? passwordValidator(String? password, String? confirmPassword) {
    if(confirmPassword == null) return getLang("enter_confirm_password_validation");
    else if (confirmPassword.length < 8) {
      return getLang("confirm_password_length_validation");
    }
    else if(password!=null){
      if(password != confirmPassword){
        return getLang("confirm_password_match_validation");
      }
    }
    // else if (!password
    //     .contains(context.read<RegisterBloc>().password.value)) {
    //   return getLang('confirmed_password_match_password');
    // }
    return null ;
  }
}

// class ChangePasswordConfirmationValidator {
//   static passwordValidator(String? password, String? confirmPassword) {
    
//     if(confirmPassword == null) return getLang("enter_confirm__validation");
//     else if (password.length < 6) {
//       return getLang("confirm_password");
//     }
//     // else if (password != context.read<PasswordBloc>().newPassword.value) {
//     //   return getLang('confirmed_password_match_password');
//     // }
//     return null;
//   }
// }

class PhoneValidator {
  static String? phoneValidator(String? phone) {
    if(phone == null){
      return "please fill the phone field";
    }
    else if (phone.length != 11 || RegExp(r'^(?:\+?0[-.●]?)?\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4})$').hasMatch(phone.trim()) == false) {
      return getLang("please_enter_valid_phone_number");
    }
    return null;
  }
}

class NameValidator {
  static String?  nameValidator(String? name) {
    if(name == null) return getLang("enter_name_validation");
    else if (name.length < 2) {
      //please_enter_valid_user_name
      return getLang("name_length_validation");
    }
    else if(name.contains(RegExp("r[1-9]"),0)){
      return getLang("number_name_validation");
    }
    return null;
  }
}


class TitleValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return getLang("please_enter_valid_title");
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')) {
      return getLang("please_enter_valid_title_without_phone");
    }
    return null;
  }
}

class DescriptionValidator {
  static String? descriptionValidator(String? name) {
    String pattern =
        '^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z][0-9]{5}*\$';
    // String pattern = '[a-z]+^[0-9]{5}\$';
    // String pattern = '^[A-Z]{3}[A-Z]{3}[0-9]{4}\$';
    //  RegExp regExp = RegExp(pattern);
    //  if (!regExp.hasMatch(name.trim())) {
    //    print("RegExp Name : "+name);
    //    return getLang("please_enter_valid_description");
    //  }
    if (name!.length < 2) {
      return getLang("please_enter_valid_description");
    } else if (name.contains('٠١٥') ||
        name.contains('٠١٢') ||
        name.contains('٠١١') ||
        name.contains('٠١٠') ||
        name.contains('015') ||
        name.contains('012') ||
        name.contains('011') ||
        name.contains('010') ||
        name.contains('http://') ||
        name.contains('https://')
    ) {
      return getLang("please_enter_valid_description_without_phone");
    }
    return null;
  }
}

class NoteValidator {
  static String? nameValidator(String? name) {
    if (name!.length < 2) {
      return getLang("please_enter_valid_description");
    }
    return null;
  }
}

class PriceValidator {
  static String? priceValidator(String? price) {
    double doublePrice = double.parse(price!);
    if (doublePrice < 1) {
      return getLang("please_enter_valid_price");
    }
    return null;
  }
}

class PriceToValidator {
  static String? priceValidator(String? price , String? stringPriceFrom,BuildContext context) {
    double priceTo = double.parse(price!);
    if (priceTo > 1) {
      double priceFrom = double.parse(stringPriceFrom!);
      if(priceTo < priceFrom){
        return getLang("please_enter_valid_price");
      }
    }else{
      return getLang("please_enter_valid_price");
    }
    return null;
  }
}

class DiscountValidator {
  static String? discountValidator(String? discount) {
    if (discount!.length < 1 || double.parse(discount) > 100.00) {
      return getLang("please_enter_valid_discount");
    }
    return null;
  }
}

class LinkValidator {
  static String? linkValidator(String? link) {
    if (!link!.contains("http")) {
      return getLang("please_enter_valid_link");
    }
    return null;
  }
}

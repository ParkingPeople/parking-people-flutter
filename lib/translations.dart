import 'package:i18n_extension/i18n_extension.dart';

const ko_kr = 'ko_kr';
const en_us = 'en_us';

class Strings {
  const Strings._();

  static const appName = 'appName';
  static const introTitle = 'introTitle';
  static const introBody = 'introBody';
  static const kakaoLogin = 'kakaoLogin';
  static const googleLogin = 'googleLogin';
  static const registerMail = 'registerMail';

  static const _t = Translations.from(ko_kr, {
    appName: {
      ko_kr: '파킹피플',
      en_us: 'ParkingPeople',
    },
    introTitle: {
      ko_kr: '안녕하세요',
      en_us: 'Hello',
    },
    introBody: {
      ko_kr: '파킹피플로 쉽게 주차공간을 찾아보세요.',
      en_us: 'Find parking spaces quick and easy with ParkingPeople.',
    },
    kakaoLogin: {
      ko_kr: '카카오 로그인',
      en_us: 'Login with Kakao',
    },
    googleLogin: {
      ko_kr: '구글 로그인',
      en_us: 'Login with Google',
    },
    registerMail: {
      ko_kr: '회원가입 하기',
      en_us: 'Register',
    },
  });
}

extension Localization on String {
  String get i18n => localize(this, Strings._t);
}

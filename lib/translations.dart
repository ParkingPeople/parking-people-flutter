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

  static const searchTitle = 'searchTitle';
  static const searchHint = 'searchHint';
  static const searchAction = 'searchAction';

  static const recommendHere = 'recommendHere';

  static const pointTitle = 'pointTitle';
  static const pointCharge = 'pointCharge';
  static const pointRemaining = 'pointRemaining';
  static const pointLiteral = 'pointLiteral';

  static const closeAgain = 'closeAgain';

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
    searchTitle: {
      ko_kr: '목적지를 알려주세요',
      en_us: 'Enter your destination',
    },
    searchHint: {
      ko_kr: '목적지 검색',
      en_us: 'Search for destinations',
    },
    searchAction: {
      ko_kr: '주차장 추천받기',
      en_us: 'Get parking lots',
    },
    recommendHere: {
      ko_kr: '현 위치에서 추천',
      en_us: 'Parking lots nearby',
    },
    pointTitle: {
      ko_kr: '포인트',
      en_us: 'My point',
    },
    pointCharge: {
      ko_kr: '충전하기',
      en_us: 'Get more points',
    },
    pointRemaining: {
      ko_kr: '현재 남은 포인트',
      en_us: 'Remaining points',
    },
    pointLiteral: {
      ko_kr: '포인트',
      en_us: 'points',
    },
    closeAgain: {
      ko_kr: '앱을 종료하려면 뒤로 버튼을 다시 누르세요',
      en_us: 'Press back button again to close the app',
    },
  });
}

extension Localization on String {
  String get i18n => localize(this, Strings._t);
}

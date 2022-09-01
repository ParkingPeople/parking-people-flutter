import 'package:i18n_extension/i18n_extension.dart';

const ko_kr = 'ko_kr';
const en_us = 'en_us';

abstract class Translatable {
  String get translationKey;

  String get translate => translationKey.i18n;
}

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

  static const String photoStatusStored = 'photoStatusStored';
  static const String photoStatusUploaded = 'photoStatusUploaded';
  static const String photoStatusAnalyzing = 'photoStatusAnalyzing';
  static const String photoStatusAnalyzed = 'photoStatusAnalyzed';

  static const String activityLevelFree = 'activityLevelFree';
  static const String activityLevelNormal = 'activityLevelNormal';
  static const String activityLevelCrowded = 'activityLevelCrowded';
  static const String activityLevelUnkown = 'activityLevelUnkown';

  static const navigate = 'navigate';

  static const locationNotFound = 'locationNotFound';
  static const allowLocationAsk = 'allowLocationAsk';

  static const searchResultEmpty = 'searchResultEmpty';

  static const parkingLotNameSkeleton = 'parkingLotNameSkeleton';
  static const toDestinationPrefix = 'toDestinationPrefix';

  static const takePhotoAction = 'takePhotoAction';

  static const photoResultTitle = 'photoResultTitle';
  static const photoResultText = 'photoResultText';
  static const photoTakenAt = 'photoTakenAt';
  static const photoCount = 'photoCount';
  static const photoCountPostfix = 'photoCountPostfix';
  static const photoState = 'photoState';
  static const photoAnalysisStateDone = 'photoAnalysisStateDone';

  static const parkingLotType_parkingLot = 'parkingLotType_PARKING_LOT';
  static const parkingLotType_building = 'parkingLotType_BUILDING';
  static const parkingLotType_street = 'parkingLotType_STREET';

  static const _translationMap = {
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
    activityLevelFree: {
      ko_kr: '여유',
      en_us: 'Free',
    },
    activityLevelNormal: {
      ko_kr: '보통',
      en_us: 'Avg.',
    },
    activityLevelCrowded: {
      ko_kr: '혼잡',
      en_us: 'Busy',
    },
    activityLevelUnkown: {
      ko_kr: '미상',
      en_us: 'N/A',
    },
    navigate: {
      ko_kr: '길 안내하기',
      en_us: 'Navigate',
    },
    locationNotFound: {
      ko_kr: '장소를 찾을 수 없습니다.',
      en_us: 'Location not found',
    },
    allowLocationAsk: {
      ko_kr: '위치 권한을 허용해주세요.',
      en_us: 'Please allow location permission',
    },
    searchResultEmpty: {
      ko_kr: '검색결과가 없습니다 :(',
      en_us: 'There were no parking lot recommendations',
    },
    parkingLotNameSkeleton: {
      ko_kr: '주차장명',
      en_us: 'Parking Lot',
    },
    toDestinationPrefix: {
      ko_kr: '목적지에서',
      en_us: 'Distance',
    },
    takePhotoAction: {
      ko_kr: '주차장 사진 촬영하기',
      en_us: 'Submit photo of parking space',
    },
    photoResultTitle: {
      ko_kr: '사진 제출 결과',
      en_us: 'Submission Result',
    },
    photoResultText: {
      ko_kr: '제출 완료',
      en_us: 'Submission completed',
    },
    photoTakenAt: {
      ko_kr: '촬영 일시',
      en_us: 'Taken at',
    },
    photoCount: {
      ko_kr: '사진 갯수',
      en_us: 'No. of photos',
    },
    photoCountPostfix: {
      ko_kr: '장',
      en_us: '',
    },
    photoState: {
      ko_kr: '상태',
      en_us: 'Status',
    },
    photoAnalysisStateDone: {
      ko_kr: '검토 완료',
      en_us: 'Analyzed',
    },
  };

  static const _t = Translations.from(ko_kr, _translationMap);
}

extension Localization on String {
  String get i18n => localize(this, Strings._t);
}

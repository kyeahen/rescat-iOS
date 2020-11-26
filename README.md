# rescat-iOS

**SOPT 23기 AppJam 대상 수상**

개발 기간 : 2018년 12월 23일  ~ 2019년 1월 12일


## [ About ]

**길고양이 정보 제공 서비스**입니다.

비회원/일반 회원/케어테이커 3개의 신분으로 앱에 접근할 수 있습니다.

**지도**를 통해 고양이 배식소, 병원, 고양이 위치를 받아볼 수 있습니다. <br>
케어테이커의 신분을 얻게 되면 자신이 활동하고 있는 지역의 고양이, 배식소 위치를 등록할 수 있습니다. <br>
케어테이크 신청은 실명 인증(휴대폰 인증), 지역 설정, 실시간 사진 인증 과정을 통해 이루어집니다.

**게시판**은 입양/임시보호(도와주세요) 게시판과 치료비 모금/프로젝트(후원할래요) 게시판으로 나눠집니다. <br>

**마이페이지**는 신분 상태에 따라 다르게 화면이 이루어집니다. <br>
메뉴는 활동 지역 설정, 내가 참여한 후원글, 내가 작성한글, 정보수정, 비밀번호 변경, 문의하기, 로그아웃으로 이루어져 있습니다. <br>
비회원인 경우, 회원가입하기 버튼만 나타나게 됩니다. <br>
일반 회원인 경우, 활동 지역 설정을 제외한 메뉴가 나타납니다. <br>
케어테이커인 경우, 모든 메뉴가 나타납니다. <br>

**푸쉬 알림**은 입양, 임시 보호 신청 및 접수에 관한 알림이 오게 됩니다.

## [ WorkFlow ]             

![workflow](https://github.com/kyeahen/rescat-iOS/blob/master/data/workflow_rescat.png)


## [ Develop Environment ]

- Language :  **Swift 4.2**
- iOS Depolyment Target : **11.0**


## [ Library ]

1. Server
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Kingfisher](https://github.com/onevcat/Kingfisher)

2. Layout
- [SnapKit](https://github.com/SnapKit/SnapKit)
- [MXSegmentedPager](https://github.com/maxep/MXSegmentedPager)
- [ImageSlideshow](https://github.com/zvonicek/ImageSlideshow)
- [AACarousel](https://github.com/Alan881/AACarousel)
- [UITextView+Placeholder](https://github.com/devxoul/UITextView-Placeholder)
- [SwiftyGifOrigin](https://github.com/swiftgif/SwiftGif)

3. Map
- [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/intro)
- [GooglePlaces](https://developers.google.com/places/web-service/intro)

4. Push
- [Firebase/core](https://github.com/firebase/firebase-ios-sdk)
- [Firebase/Messaging](https://github.com/firebase/firebase-ios-sdk)

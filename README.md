# 원티드 프리온보딩 iOS 과정
### 과제 사항
- Open Weather API를 활용하여 다음을 충족하는 앱을 구현하라.
- 첫번째 화면
    - 아래 각 도시의 현재 날씨를 화면에 표시합니다.
        - 필수로 포함해야 하는 정보
            - 도시이름, 날씨 아이콘, 현재기온, 현재습도
                
                > 공주, 광주(전라남도), 구미, 군산, 대구, 대전, 목포, 부산, 서산, 서울, 속초, 수원, 순천, 울산, 익산, 전주, 제주시, 천안, 청주, 춘천
            - 날씨 아이콘의 경우 API에서 제공하는 아이콘을 활용합니다.  
![FIRST](previews/firstRecord.gif)

- 두번째 화면
    - 첫 번째 화면에서 선택한 도시의 현재 날씨 상세 정보를 표현합니다
        - 필수로 포함해야하는 정보
            > 도시이름, 날씨 아이콘, 현재기온, 체감기온, 현재습도, 최저기온, 최고기온, 기압, 풍속, 날씨설명
        - 날씨 아이콘 이미지를 불러올때는 캐시를 활용합니다.
            - 캐시 정보가 있다면 캐시 이미지를 활용합니다.
            - 캐시 정보가 없다면 API로 부터 이미지를 받아옵니다.
![SECOND](previews/secondRecord.gif)


## 기술 스택
### 구조
    - MVC
### UI
    - UIKit
### Network
    - URLSession
    - Codable
    - JSONDecoder
### Cache
    - NSCache

## 구현 방법
    - 지정된 지역의 위치를 JSON으로 파싱하여, 로컬 데이터로 지정
![THIRD](previews/geometryPreviews.png)

    - 지정된 지역에 대한 API를 각각 실행하여, Json Decoder를 활용하여 데이터를 생성
![Sixth](previews/decodeFunctions.png)

    - API 통신을 담당하는 서비스를 싱글톤으로 제작하여서 활용
![FOURTH](previews/ApiService.png)

    - NSCache를 통해서 이미 캐싱 여부를 판단하여 image를 로드
![FIFTH](previews/ImageCacheChecker.png)
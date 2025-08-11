# 📌 RecipeCode 프로젝트
> 간단한 한 줄 소개  
> 예: "유저 커뮤니티 친화적인 레시피 사이트"

---

## 📜 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [주요 기능](#주요-기능)
3. [기술 스택](#기술-스택)
4. [시스템 아키텍처](#시스템-아키텍처)
5. [와이어프레임 & 화면 구성](#와이어프레임--화면-구성)
6. [실행 방법](#실행-방법)
7. [팀원 & 역할분담](#팀원--역할분담)
8. [라이선스](#라이선스)

---

## 💡 프로젝트 소개
- 프로젝트 개요:
  - 흔한 정보 제공용 사이트가 아닌 유저들끼리의 소통이 중심인 레시피사이트
  - 요리레시피를 주제로 의견을 나누고 싶어하는 사람들을 위한 장소
- 개발 기간: 2025.07.01 ~ 2025.07.31 (예시)


---

## 🚀 주요 기능
- **검색**: 조건별 데이터 검색 (예: 위치 기반 충전소 조회)
- **필터**: 카테고리/장르별 필터 기능
- **시각화**: 혼잡도, 사용량 그래프 표시
- **인증**: 회원가입, 로그인 
- **기타**: 반응형 UI,  등

---

## 🛠 기술 스택
| 분야       | 기술명 |
|------------|--------|
| **Frontend** | React, JavaScript(ES6+), HTML5, CSS3, Bootstrap |
| **Backend**  | Spring Boot, JPA, MySQL |
| **Infra**    | AWS EC2, S3, RDS |
| **Tools**    | Git, GitHub, Postman, Figma |

---

## 🗂 시스템 아키텍처
![architecture](docs/architecture.png)

---

## 🎨 와이어프레임 & 화면 구성
- 와이어프레임: [Figma 링크](https://www.figma.com/...)
- 주요 화면  
  | 메인 페이지 | 검색 페이지 | 상세 페이지 |
  |-------------|-------------|-------------|
  | ![](docs/screenshot-main.png) | ![](docs/screenshot-search.png) | ![](docs/screenshot-detail.png) |

---

## ⚙ 실행 방법
```bash
# 1. 레포지토리 클론
git clone https://github.com/username/project-name.git

# 2. 환경 변수 설정
cp .env.example .env

# 3. 백엔드 실행
cd backend
./gradlew bootRun

# 4. 프론트엔드 실행
cd frontend
npm install
npm start

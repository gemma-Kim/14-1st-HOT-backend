# 14-1st-HOT-backend
# Introduction
![](https://camo.githubusercontent.com/d79cb7990081df1af527139dea2ea3b2c284457e954d08677e72e0c95cc31aa0/68747470733a2f2f6966682e63632f672f4e32794d50612e706e67)
> 진행기간: 2020년 11월 16일 ~ 2020년 11월 27일
- 팀명 : House Of Tomorrow (H.O.T)
- 목적 : [오늘의 집 공식 사이트](https://ohou.se/) 를 클론하면서 장고의 기본기와 협업 역량을 향상한다.
- 개발 Process : 여러가지 소프트웨어 개발 방법론 중 많이 사용되는 Scrum 방법론을 채택하여 일주일 단위로 Sprint를 나누고, 주간 미팅과 데일리 스탠딩 미팅을 통해 각 팀원의 진행사항 및 계획에 대해 공유하며 진행하였다.
- 오늘의 집 서비스 특징 : 커뮤니티와 스토어를 서로 연결시켜 두었다는 것이 가장 큰 장점이다. 즉, 피드를 구경하다 방을 구성하고 있는 제품들에 대한 정보를 바로 알 수 있고 구매까지 할 수 있다. 또한 제품을 고르다 해당 제품이 게시된 피드를 보러 커뮤니티로 바로 이동할 수도 있다.
## Team Members
🐶 Front-end ([github repo](https://github.com/wecode-bootcamp-korea/14-1st-HOT-frontend))
- 안상혁 (PM) - [github](https://github.com/Xednicoder)
- 공주민 - [github](https://github.com/rhdwnals1)
- 이승윤 - [github](https://github.com/14-yoonl)

🐼 Back-end ([github repo](https://github.com/wecode-bootcamp-korea/14-1st-HOT-backend))
- 강두연 - [github](https://github.com/dooyeonk), [후기](https://velog.io/@dooyeonk/%EC%98%A4%EB%8A%98%EC%9D%98-%EC%A7%91-%ED%81%B4%EB%A1%A0-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9B%84%EA%B8%B0-%EB%B0%B1%EC%97%94%EB%93%9C)
- 김기용 - [github](https://github.com/amusesla)
- 김민서 - [github](https://github.com/gemma-Kim)

# Technologies
- Python
- Regular Expression
- Django
- MySQL
- JWT, Bcrpyt
- Git & GitHub
- AWS EC2, AWS RDS

# Modelling
![](https://images.velog.io/images/dooyeonk/post/0a3d50eb-2646-4feb-ae5d-3661e4280402/image.png)

# Implementations
- 모델링 \[Aquery Tool]
- 회원가입 엔드포인트 \[bcrypt (DB에 암호화된 비밀번호 저장)] - POST
- 로그인 엔드포인트 \[bcrpyt (비밀번호 대조), JWT(토큰 생성)] - POST
- 로그인 확인 데코레이터 - JWT(토큰 복호화)
- 팔로우 & 언팔로우 - POST
- 좋아요 & 좋아요 취소 - POST
- 북마크 & 북마크 취소 - POST
- 마이페이지 - GET
- 장바구니 - POST, GET
- 상품 리스트 엔드포인트 (정렬 및 검색 포함) - GET
- 카테고리 별 상품 리스트 - GET
- 상품 상세페이지 - GET
- 포스트 리스트 (정렬 포함) - GET
- 포스트 상세페이지 - GET, PUT, DELETE
- 댓글 - GET, POST, PATCH, DELETE

# Api Document
- 강두연
  - \[포스트리스트 불러오기] GET /posts (?sort='\<"like"| "postbookmark" | "comment"\>')
  - \[포스트상세정보 불러오기] GET /posts/\<int:post_id\>
  - \[포스트 수정하기] PUT /posts/\<int:post_id\>
  - \[포스트 삭제하기] DELETE /posts/\<int:post_id\>
  - \[댓글 등록하기] POST /posts/\<int:post_id\>/comments
  - \[댓글 불러오기] GET /posts/\<int:post_id\>/comments
  - \[댓글 수정하기] PATCH /posts/\<int:post_id\>/comments/\<int:comment_id\>
  - \[댓글 삭제하기] DELETE /posts/\<int:post_id\>/comments/\<int:comment_id\>
  
- 김민서
  - \[회원가입] POST /user/register
  - \[로그인] POST /user/login
  - \[포스트 좋아요 등록하기] POST /user/like
  - \[포스트 좋아요 취소하기] POST /user/unlike
  - \[유저 팔로우 등록하기] POST /user/like
  - \[유저 팔로우 취소하기] POST /user/unlike
  - \[콜렉션 / 프로덕트 / 포스트 북마크 등록하기] POST /user/bookmark
  - \[콜렉션 / 프로덕트 / 포스트 북마크 취소하기] POST /user/unbookmark
  - \[마이페이지 정보 불러오기] GET /user/mypage
  
- 김기용
  - \[제품 리스트 필터 및 검색] GET /store/products (?menu=1&category=1&sub_category=1&search=[제품명])
  - \[제품 카테고리 리스트] GET /store/categoreis?menu=1
  - \[제품 디테일] GET /sotre/<int:product_id>

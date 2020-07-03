# KU_Lecture-evaluation


환경설정
------------
-JDK 1.8.0_181 jre 1.80_231

-apache tomcat 8.5

-Eclpise Jee Photon

사용 언어 , 프레임워크
-----------
-Java(Main), jsp , Pooper , mysql

-html,css(bootstrap)

기능
-----------
- login , logout , 회원가입 + 간단한 로그인 세션 유지 기능

  javamail을 사용하여 메일 인증, 신고 기능 추가. SHA256을 사용해 이메일값 해쉬처리 + salt처리
  
  
- 기본적인 CRUD 시스템
  
  게시판 글 작성 삭제 , 수정 , 열람 , 추천 기능 구현
  
  pagenation을 사용하여 게시판 이전과 다음 버튼 구현
  

- 검색엔진 기능
  
  getList를 사용하여 사용하여 사용자가 검색한 내용을 글로 반환시킴.


- 사소한 보안기능 추가

  강의평가 제목이나 내용 혹은 회원가입에 xss코드가 삽입될 수 없도록 특수문자를 html 엔터티코드로 치환시켜주는 기능 구현 
  

Screenshots

![1](https://user-images.githubusercontent.com/34633494/86464542-ad4e6300-bd6a-11ea-8807-1e472225ec30.PNG)

![2](https://user-images.githubusercontent.com/34633494/86464546-af182680-bd6a-11ea-9994-e98872f66867.PNG)

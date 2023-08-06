# PartyShare
About Final Project _ Spring 활용 / PartyShare / Team Project

이걸해내조 노션 https://www.notion.so/The-Project-PartyShare-eddb4277b316476ea479c4c664952e15

## 구성원 및 역할

- 김서영 : 전반적인 일정관리 및 지도구현, 팀게시판, 친구관리, 파티원 관리, 파티정보수정, 내 파티목록 및 내 일정 보기 구현
- 김선국 : 메인화면, 파티개설 및 사진 업로드, 팀채팅, 내정보 관리 구현
- 김진우 : 회원가입, 로그인, 관리자-회원관리, 블랙리스트관리 구현
- 이진형 : UI 총괄 및 파티상세페이지, 참가확정, 자유게시판, 위시리스트, 챗봇 구현
- 이인 : 검색, 알림, 신고하기 및 신고관리, 관리자-파티목록 및 관리 구현

### member, party sample data
```
INSERT INTO member (mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES ('admin','admin','admin','관리자',30,'F','adminEmail','adminAddr');

INSERT INTO party (pName,host,sido,sigungu,address,startdate,enddate,maincategory)
VALUES ('testparty',1,'부산','해운대구','내주소','2023-08-06',CURDATE(),'게임');
```

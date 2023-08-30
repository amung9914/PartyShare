create database partyShare;
ALTER SCHEMA `partyShare`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_bin ;
use partyShare;
SELECT * FROM party;
CREATE TABLE member 	  -- 회원테이블 
(
    mNum    INT primary key auto_increment,    
    mId       VARCHAR(20) NOT NULL unique, 
    mPw       VARCHAR(20) NOT NULL, 
    mName     VARCHAR(20) NOT NULL, 
    mNick 	  VARCHAR(20) NOT NULL unique, 
    mAge      INT NOT NULL, 
    mGender   CHAR(1) NOT NULL, 
    mEmail     VARCHAR(50) NOT NULL unique, 
    mBanCnt 	INT  default 0,
    mAddr 		VARCHAR(50) NOT NULL, 
    mJoinCnt 	INT  default 0,
    mBlackYN CHAR(1) default 'N',
    withdraw CHAR(1) default 'N',
    profileImage BLOB,
    profileImageName BLOB
);

CREATE TABLE party -- 파티 
(
    pNum    INT primary key auto_increment,    
    pName       VARCHAR(50) NOT NULL ,
    host       INT NOT NULL ,
    sido     	VARCHAR(20) NOT NULL ,
    sigungu 	VARCHAR(20) NOT NULL ,
    address    VARCHAR(50) NOT NULL , -- 도로명 주소
    detailAddress VARCHAR(50) , -- 상세주소
    startDate   DATE NOT NULL ,
    endDate     DATE NOT NULL ,
    pContext 	TEXT ,
    mainCategory 	VARCHAR(20) NOT NULL , -- 대분류
    subCategory 	VARCHAR(20),		-- 소분류
    finish 		CHAR(1) default 'N',
    viewCnt  	INT,
    partyImage1 BLOB,
    partyImage2 BLOB,
    partyImage3 BLOB,
    FOREIGN KEY (host) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE wishlist 	-- 위시리스트-- 
(
	 no       INT primary key,
    mNum   		int,	
    pNum       VARCHAR(50) NOT NULL ,
    alias  VARCHAR(20) NOT NULL,
    FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE freeboard  -- --자유게시판--  
(
    bno    INT primary key auto_increment,    
    category    VARCHAR(20) NOT NULL ,   -- 공지/일반
    title       VARCHAR(20) NOT NULL ,
    context   	TEXT ,
    date 		DATE,
    mNick     VARCHAR(20),
    viewCnt   int ,
    FOREIGN KEY (mNick) REFERENCES member(mNick) ON UPDATE CASCADE
);
ALTER TABLE freeboard
ADD COLUMN mid varchar(20),
ADD CONSTRAINT fk_freeboard_member
FOREIGN KEY (mid) REFERENCES member(mid)
ON UPDATE CASCADE;



CREATE TABLE partyboard(
	bno INT PRIMARY KEY auto_increment, 	-- 게시글 번호
    pnum INT NOT NULL, 						-- 파티 번호
	title VARCHAR(200) NOT NULL,			-- 제목
	content LONGTEXT NOT NULL,				-- 내용
	writer VARCHAR(50) NOT NULL,			-- 작성자 이름
    category VARCHAR(20) NOT NULL,			-- 카테고리
	origin INT NULL DEFAULT 0,				-- 원본글 그룹 번호
	depth INT NULL DEFAULT 0,				-- view 깊이 번호
	seq INT NULL DEFAULT 0,					-- 답변글 정렬 순서
	regdate TIMESTAMP NULL DEFAULT NOW(), 	-- 게시글 등록 시간
	updatedate TIMESTAMP NULL DEFAULT now(),-- 게시글 수정 시간
	viewcnt INT NULL DEFAULT 0,				-- 조회수
	showboard VARCHAR(10) NULL DEFAULT 'y',	-- 게시글 삭제요청 여부
	mnum INT NOT NULL,						-- 게시글 작성자 회원번호
	reported char(1) default 'N',
	CONSTRAINT fk_partyboard_mnum
	FOREIGN KEY(mnum) REFERENCES member(mnum),
    CONSTRAINT fk_partyboard_pnum
	FOREIGN KEY(pnum) REFERENCES party(pnum)
);

CREATE TABLE chat  -- --채팅--  
(
    pNum    INT primary key auto_increment,   
    context  VARCHAR(20)  NOT NULL,
    finish    VARCHAR(20) NOT NULL ,  
    FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE
);


CREATE TABLE friend  -- --친구 추가 --  
(
	no	INT primary key,
    fFrom     VARCHAR(20)  NOT NULL,   
    fTo  VARCHAR(20)  NOT NULL,
    YN    CHAR(1) NOT NULL ,  
    msg  VARCHAR(50)  ,
    FOREIGN KEY (fFrom) REFERENCES member(mNick) ON UPDATE CASCADE,
    FOREIGN KEY (fTo) REFERENCES member(mNick) ON UPDATE CASCADE
);

CREATE TABLE joinmember   -- 파티 참여 인원 --  
(
	no	INT primary key,
    pNum    INT NOT NULL,   
    mNum  	INT  NOT NULL,
    FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE,
    FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE partylocation   -- 파티장소 --   -- 진행 중
(	
    pNum   	INT primary key,
    lat  	double  NOT NULL,
    lng     double	NOT NULL
);


CREATE TABLE blacklist  -- -- admin 블랙리스트 --  
(
    no    	INT primary key auto_increment,  
    mNum     INT  NOT NULL,   
    date  	 date NOT NULL,
	FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);


CREATE TABLE report  -- -- 신고내역 --  
(
    no    		INT primary key auto_increment,  
    fromMid     VARCHAR(20)  NOT NULL,  
    toMid 		VARCHAR(20)  NOT NULL,
    date  		date NOT NULL,
    category   VARCHAR(20) NOT NULL,   -- 신고 카테고리 
    context    TEXT  NOT NULL,   -- 신고 내용 
	FOREIGN KEY (fromMid) REFERENCES member(mId) ON UPDATE CASCADE,
    FOREIGN KEY (toMid) REFERENCES member(mId) ON UPDATE CASCADE
);

CREATE TABLE notice  -- -- 알림 --  
(
    noticeNum    	INT primary key auto_increment,  
    date  			 date NOT NULL,
    context   		 TEXT  NOT NULL   
);

CREATE TABLE location(
sido varchar(20) not null,
sigungu varchar(20) not null,
no  int auto_increment primary key
);

CREATE TABLE banmember -- -- 신고내역 --
(
no INT primary key auto_increment,
pNum INT NOT NULL,
mNum INT NOT NULL,
FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE,
FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);
select * from partydescription ;
CREATE TABLE map -- -- 지도 --
(
no INT primary key auto_increment,
pNum INT NOT NULL,
lat VARCHAR(50) NOT NULL, -- 위도 y좌표 lat
lng VARCHAR(50) NOT NULL, -- 경도 x좌표 lng
FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE
);



ALTER TABLE friend -- 친구 테이블
DROP COLUMN msg;

-- auto_increment 속성 추가
ALTER TABLE joinmember   
MODIFY COLUMN no INT AUTO_INCREMENT;

ALTER TABLE wishlist 	
MODIFY COLUMN no INT AUTO_INCREMENT;


-- 아래부터 카테고리 수정분입니다.

-- 파티 설명 테이블 ex)광란의
CREATE TABLE partydescription (
    no INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(20) NOT NULL -- FK
);

-- 파티 주제 테이블 ex)캠핑
CREATE TABLE partycategory(
    no INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(20) NOT NULL  -- FK
);


INSERT INTO partycategory (category)
VALUES
('요리/제조'),
('아웃도어/여행'),
('운동/스포츠'),
('책/글'),
('업종/직무'),
('외국/언어'),
('문화/공연/축제'),
('음악/악기'),
('공예/만들기'),
('댄스/무용'),
('봉사활동'),
('사교/인맥'),
('차/오토바이'),
('사진/영상'),
('야구관람'),
('게임/오락'),
('반려동물'),
('가족/결혼'),
('그외');
DELETE  FROM partycategory where no >=105;
select * from partycategory;
INSERT INTO partydescription (description)
VALUES
('기상천외한 파티'),
('초소형주택에서하는 파티'),
('캠핑장'),
('해변바로앞'),
('멋진 수영장'),
('속세를 벗어난 숙소'),
('럭셔리'),
('대저택'),
('창작파티'),
('보트'),
('서핑'),
('골프');


-- 카테고리 table 컬럼명에 맞추어 party table 컬럼명 변경
ALTER TABLE party
CHANGE COLUMN mainCategory description VARCHAR(20) NOT NULL,  -- ex)광란의
DROP COLUMN subCategory,
ADD COLUMN category VARCHAR(20) NOT NULL; -- ex)캠핑 

-- 파티게시판 조회수 컬럼 수정
ALTER TABLE partyboard
CHANGE COLUMN viewcnt viewcnt INT default 0;	

-- member 테이블 party 테이블 이미지 컬럼 수정
alter table member drop column profileImage;
alter table member modify column profileImageName varchar(256);
alter table party modify column partyImage1 varchar(256);
alter table party modify column partyImage2 varchar(256);
alter table party modify column partyImage3 varchar(256);

-- 친구 테이블 수정
DROP TABLE friend;
CREATE TABLE friend  -- --친구 추가 --  
(
	no	INT primary key auto_increment,
    fFrom int NOT NULL,   
    fTo int NOT NULL,
    YN CHAR(1) default 'N',
    requestTime TIMESTAMP default NOW(), 
    FOREIGN KEY (fFrom) REFERENCES member(mnum) ON UPDATE CASCADE,
    FOREIGN KEY (fTo) REFERENCES member(mnum) ON UPDATE CASCADE
);

-- 채팅 테이블 수정

DROP TABLE chat;

CREATE TABLE chat(
   cNum INT PRIMARY KEY AUTO_INCREMENT,
   pNum INT,
   mNum INT,
   content TEXT NOT NULL,
   finish CHAR NOT NULL DEFAULT 'N',
   FOREIGN KEY (pNum) REFERENCES party (pNum) ON UPDATE CASCADE,
   FOREIGN KEY (mNum) REFERENCES member (mNum) ON UPDATE CASCADE
);

-- notice table 수정
ALTER table notice modify column date TIMESTAMP default now();
ALTER table notice add column readed char(1) default 'N';

-- freeBoard 컬럼 수정
ALTER TABLE freeboard MODIFY COLUMN date DATETIME;

-- freeBoard 댓글 테이블 추가
CREATE TABLE IF NOT EXISTS freeboard_comment(
   cno INT PRIMARY KEY AUTO_INCREMENT,         -- 댓글 번호
   bno INT NOT NULL,                      -- 댓글 작성 게시글 번호
   commentText TEXT NOT NULL,               -- 댓글 내용
   mnick VARCHAR(20) NOT NULL,               -- 작성자 닉네임
   mid VARCHAR(20) NOT NULL,               -- 작성자 아이디
   regdate DATETIME NOT NULL DEFAULT now(),   -- 작성시간
   FOREIGN KEY(bno) REFERENCES freeboard(bno) ON DELETE CASCADE,
   FOREIGN KEY(mnick) REFERENCES member(mNick) ON UPDATE CASCADE,
   FOREIGN KEY(mid) REFERENCES member(mId) ON UPDATE CASCADE
);





-- 파티 게시판 댓글 테이블 생성

CREATE TABLE partyboard_comment(
	cno INT PRIMARY KEY AUTO_INCREMENT,			-- 댓글 번호
	bno INT NOT NULL,							-- 댓글 작성 게시글 번호
	pnum INT NOT NULL,							-- 파티 번호
	commentText TEXT NOT NULL,					-- 댓글 내용
	mnick VARCHAR(20) NOT NULL,					-- 작성자 닉네임
	mid VARCHAR(20) NOT NULL,					-- 작성자 아이디
	regdate TIMESTAMP NOT NULL DEFAULT now(),	-- 작성시간
	updatedate TIMESTAMP NOT NULL DEFAULT now(),-- 수정시간
	reported char(1) default 'N',
	FOREIGN KEY(bno) -- 참조무결성 추가
	REFERENCES partyboard(bno) ON DELETE CASCADE,
	FOREIGN KEY(pnum) REFERENCES party(pnum) ON DELETE CASCADE,
	FOREIGN KEY(mnick) REFERENCES member(mnick) ON DELETE CASCADE,
	FOREIGN KEY(mid) REFERENCES member(mid) ON DELETE CASCADE,
	INDEX(bno)									-- 인덱스 추가
);

-- 파티게시판 신고내역테이블 신규 생성
CREATE TABLE partyboard_report  
(
    no    		INT primary key auto_increment,  
    fromMid     VARCHAR(20)  NOT NULL,  
    toMid 		VARCHAR(20)  NOT NULL,
    date  		 TIMESTAMP default now(),
    category   VARCHAR(20) NOT NULL,   -- 신고 카테고리 
    context    TEXT  NOT NULL,   -- 신고 내용 
    readed char(1) default 'N',
    pnum INT, -- 파티번호
    bno INT, -- 게시글 번호
    cno INT, -- 댓글 번호
	FOREIGN KEY (pnum) REFERENCES party(pnum)ON DELETE CASCADE,
	FOREIGN KEY (bno) REFERENCES partyboard(bno)ON DELETE CASCADE,
	FOREIGN KEY (cno) REFERENCES partyboard_comment(cno)ON DELETE CASCADE,
	FOREIGN KEY (fromMid) REFERENCES member(mId) ON UPDATE CASCADE,
    FOREIGN KEY (toMid) REFERENCES member(mId) ON UPDATE CASCADE
);


-- 신고 관련 수정
ALTER TABLE report
ADD COLUMN bno INT null,
ADD FOREIGN KEY (bno) REFERENCES freeboard(bno);

ALTER TABLE report
ADD COLUMN cno INT,
ADD FOREIGN KEY (cno) REFERENCES freeboard_comment(cno);

alter table freeboard_comment add column reported char(1) default 'N';
alter table freeboard add column reported char(1) default 'N'; 


--  freeBoard , freeBoardComment , partyboard , partyboard_comment reported -> showBoard 이름만 변경

ALTER TABLE partyboard_comment drop column reported; 
ALTER TABLE partyboard_comment add column showBoard char(1) default 'Y'; 

ALTER TABLE partyboard drop column reported; 

ALTER TABLE freeboard_comment drop column reported; 
ALTER TABLE freeboard_comment add column showBoard char(1) default 'Y'; 
ALTER TABLE freeboard drop column reported; 
ALTER TABLE freeboard add column showBoard char(1) default 'Y'; 


INSERT INTO member (mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES ('admin','admin','admin','관리자',30,'F','adminEmail','adminAddr');
INSERT INTO member (mnum,mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES (2,'id001','1111','김서영','김서영',30,'F','김서영Email','김서영Addr');
INSERT INTO member (mnum,mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES (3,'id002','1111','이진형','이진형',30,'M','2Email','2Addr');
INSERT INTO member (mnum,mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES (4,'id003','1111','김선국','김선국',30,'M','3Email','3Addr');
INSERT INTO member (mnum,mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES (5,'id004','1111','이인','이인',30,'M','4Email','4Addr');
INSERT INTO member (mnum,mId,mPw,mName,mNick,mAge,mGender,mEmail,mAddr)
VALUES (6,'id005','1111','김진우','김진우',30,'M','5Email','5Addr');

INSERT INTO party (pnum,pName,host,sido,sigungu,address,startdate,enddate,category,description)
VALUES (1,'testparty',1,'부산','해운대구','내주소',NOW(),NOW(),'책/글','창작파티');
INSERT INTO party (pnum,pName,host,sido,sigungu,address,startdate,enddate,category,description)
VALUES (2,'testparty',1,'부산','해운대구','내주소',NOW(),NOW(),'책/글','창작파티');
INSERT INTO party (pnum,pName,host,sido,sigungu,address,startdate,enddate,category,description)
VALUES (3,'testparty',1,'부산','해운대구','내주소',NOW(),NOW(),'책/글','창작파티');
INSERT INTO party (pnum,pName,host,sido,sigungu,address,startdate,enddate,category,description)
VALUES (4,'testparty',1,'부산','해운대구','내주소',NOW(),NOW(),'책/글','창작파티');

INSERT INTO joinmember(pnum, mnum)
VALUES
  (1, 1), (2, 1), (3, 1), (4, 1),
  (1, 2), (2, 2), (3, 2), (4, 2),
  (1, 3), (2, 3), (3, 3), (4, 3),
  (1, 4), (2, 4), (3, 4), (4, 4),
  (1, 5), (2, 5), (3, 5), (4, 5),
  (1, 6), (2, 6), (3, 6), (4, 6);

commit; -------------------------------------------------

CREATE TABLE dateindex ( 
date int 
);
insert into dateindex value (1);
insert into dateindex value (3);
insert into dateindex value (7);
insert into dateindex value (15);
insert into dateindex value (30);
insert into dateindex value (60);
insert into dateindex value (90);
SELECT * FROM dateindex ;

CREATE TABLE partyCategory (
category varchar(20),
no int primary key AUTO_INCREMENT
);

CREATE TABLE partyDescription (
description varchar(20),
no int primary key AUTO_INCREMENT
);

INSERT INTO member (mId,      mPw     ,mName ,mNick,mAge,mGender,mEmail,mAddr) 	
VALUES 			('reporter2','1234','reporter2','reporter2',1 ,   'm','reporter2',  'house');

INSERT INTO report (fromMid ,     toMid    , category , context ,   bno ,  cno)	VALUES 
					('target', 'reporter2' , '광고성 댓글입니다', '나빠요' ,   1,   6   );
					
INSERT INTO report (fromMid ,     toMid    , category , context ,   bno )	VALUES 
					('reporter2', 'target' , '그냥 나쁨', '나빠요' ,   4   );
select * FROM freeBoardComment;
select * from freeBoard;
select * from partyboard_comment;
select * from partyboard;
desc freeboard;		
desc freeBoardComment;
INSERT INTO freeboard(category , title , context, mNick , mid ) VALUES 
					('기타' , '네번째' , '제곧내' , 'reporter2' , 'reporter2');
					
INSERT INTO freeboard_comment
					(commentText , mnick , mid ,bno) VALUES 
					('3번 board의 2번째 댓글' , 'reporter2' , 'reporter2' ,3 );

	select * from partycategory;					
select * from member;			
select * FROM freeboard_comment;
select * from partyboard_report;

commit;
desc partyboard_comment;


INSERT INTO location (sido, sigungu) VALUES
('서울', '종로구'),
('서울', '중구'),
('서울', '용산구'),
('서울', '성동구'),
('서울', '광진구'),
('서울', '동대문구'),
('서울', '중랑구'),
('서울', '성북구'),
('서울', '강북구'),
('서울', '도봉구'),
('서울', '노원구'),
('서울', '은평구'),
('서울', '서대문구'),
('서울', '마포구'),
('서울', '양천구'),
('서울', '강서구'),
('서울', '구로구'),
('서울', '금천구'),
('서울', '영등포구'),
('서울', '동작구'),
('서울', '관악구'),
('서울', '서초구'),
('서울', '강남구'),
('서울', '송파구'),
('서울', '강동구');

INSERT INTO location (sido, sigungu) VALUES
('부산', '중구'),
('부산', '서구'),
('부산', '동구'),
('부산', '영도구'),
('부산', '부산진구'),
('부산', '동래구'),
('부산', '남구'),
('부산', '북구'),
('부산', '해운대구'),
('부산', '사하구'),
('부산', '금정구'),
('부산', '강서구'),
('부산', '연제구'),
('부산', '수영구'),
('부산', '사상구'),
('부산', '기장군');

-- 대구광역시
INSERT INTO location (sido, sigungu) VALUES
('대구', '중구'),
('대구', '동구'),
('대구', '서구'),
('대구', '남구'),
('대구', '북구'),
('대구', '수성구'),
('대구', '달서구'),
('대구', '달성군');

-- 인천광역시
INSERT INTO location (sido, sigungu) VALUES
('인천', '중구'),
('인천', '동구'),
('인천', '남구'),
('인천', '미추홀구'),
('인천', '연수구'),
('인천', '남동구'),
('인천', '부평구'),
('인천', '계양구'),
('인천', '서구'),
('인천', '강화군'),
('인천', '옹진군');
INSERT INTO location (sido, sigungu) VALUES
('광주', '동구'),
('광주', '서구'),
('광주', '남구'),
('광주', '북구'),
('광주', '광산구');

-- 대전광역시
INSERT INTO location (sido, sigungu) VALUES
('대전', '동구'),
('대전', '중구'),
('대전', '서구'),
('대전', '유성구'),
('대전', '대덕구');

-- 울산광역시
INSERT INTO location (sido, sigungu) VALUES
('울산', '중구'),
('울산', '남구'),
('울산', '동구'),
('울산', '북구'),
('울산', '울주군');

-- 세종특별자치시
INSERT INTO location (sido, sigungu) VALUES
('세종', '세종');
--------------------------------------------------------------------------

create database PartyShare;
use PartyShare;
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

CREATE TABLE wishList 	-- 위시리스트-- 
(
	 no       INT primary key,
    mNum   		int,	
    pNum       VARCHAR(50) NOT NULL ,
    FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE freeBoard  -- --자유게시판--  
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

CREATE TABLE partyBoard  -- --파티 게시판--  
(
    bno    INT primary key auto_increment,   
    pNum 	INT,
    category    VARCHAR(20) NOT NULL ,   -- 공지/일반
    title       VARCHAR(20) NOT NULL ,
    context   	TEXT ,
    date 		DATE,
    mNick     VARCHAR(20),
    viewCnt   int ,
    FOREIGN KEY (mNick) REFERENCES member(mNick) ON UPDATE CASCADE,
    FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE
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

CREATE TABLE joinMember   -- 파티 참여 인원 --  
(
	no	INT primary key,
    pNum    INT NOT NULL,   
    mNum  	INT  NOT NULL,
    FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE,
    FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE partyLocation   -- 파티장소 --   -- 진행 중
(	
    pNum   	INT primary key,
    lat  	double  NOT NULL,
    lng     double	NOT NULL
);

CREATE TABLE joinPartyList  -- -- 참가 중인 파티 목록 --  
(
	no	INT primary key,
    mNum     INT  NOT NULL,   
    pNum  	 INT  NOT NULL,
    pName    CHAR(20) NOT NULL ,  
    startDate  date NOT NULL ,
    endDate   date NOT NULL, 
    finish	CHAR(1),
    FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE,
    FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE
);

CREATE TABLE blackList  -- -- admin 블랙리스트 --  
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

CREATE TABLE notice  -- -- 신고내역 --  
(
    noticeNum    	INT primary key auto_increment,  
    date  			 date NOT NULL,
    context   		 TEXT  NOT NULL   -- 신고 내용 
);

CREATE TABLE banMember -- -- 신고내역 --
(
no INT primary key auto_increment,
pNum INT NOT NULL,
mNum INT NOT NULL,
FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE,
FOREIGN KEY (mNum) REFERENCES member(mNum) ON UPDATE CASCADE
);

CREATE TABLE map -- -- 지도 --
(
no INT primary key auto_increment,
pNum INT NOT NULL,
lat VARCHAR(50) NOT NULL, -- 위도 y좌표 lat
lng VARCHAR(50) NOT NULL, -- 경도 x좌표 lng
FOREIGN KEY (pNum) REFERENCES party(pNum) ON UPDATE CASCADE
);

ALTER TABLE joinpartylist -- 참여중인 파티테이블
DROP COLUMN pname,
DROP COLUMN startDate,
DROP COLUMN endDate,
DROP COLUMN finish;

ALTER TABLE friend -- 친구 테이블
DROP COLUMN msg;

-- auto_increment 속성 추가
ALTER TABLE joinMember   
MODIFY COLUMN no INT AUTO_INCREMENT;

ALTER TABLE wishList 	
MODIFY COLUMN no INT AUTO_INCREMENT;

-- joinpartylist 중복 테이블 삭제
drop table joinpartylist;

-- 아래부터 카테고리 수정분입니다.

-- 파티 설명 테이블 ex)광란의
CREATE TABLE partyDescription (
    no INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(20) NOT NULL -- FK
);

-- 파티 주제 테이블 ex)캠핑
CREATE TABLE partyCategory(
    no INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(20) NOT NULL  -- FK
);


INSERT INTO partyCategory (category)
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

INSERT INTO partyDescription (description)
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

-- wishlist에 별칭 칼럼 추가
ALTER TABLE wishlist ADD alias VARCHAR(20) NOT NULL;

-- 카테고리 table 컬럼명에 맞추어 party table 컬럼명 변경
ALTER TABLE party
CHANGE COLUMN mainCategory description VARCHAR(20) NOT NULL,  -- ex)광란의
DROP COLUMN subCategory,
ADD COLUMN category VARCHAR(20) NOT NULL; -- ex)캠핑 

-- 파티게시판 조회수 컬럼 수정
ALTER TABLE partyBoard
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

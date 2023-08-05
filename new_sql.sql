create database PartyShare2;
use PartyShare;
drop table party;
drop table member;
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
    withdraw CHAR(1) default 'N'
);
DESC MEMBER;
DESC party;

CREATE TABLE party -- 파티 
(
    pNum    INT primary key auto_increment,    
    pName       VARCHAR(50) NOT NULL ,
    host       INT NOT NULL ,
    city     	VARCHAR(20) NOT NULL ,
    district 	VARCHAR(20) NOT NULL ,
    location    VARCHAR(50) NOT NULL ,
    startDate   DATE NOT NULL ,
    endDate     DATE NOT NULL ,
    pContext 	TEXT ,
    mainCategory 	VARCHAR(20) NOT NULL , -- 대분류
    subCategory 	VARCHAR(20),		-- 소분류
    finish 		CHAR(1) default 'N',
    viewCnt  	INT,
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


CREATE TABLE partyImage  -- --파티 이미지--  
(
    imgNum    INT primary key auto_increment,   
    imgName  VARCHAR(20)  NOT NULL,
    imgid    VARCHAR(20) NOT NULL ,   -- 공지/일반
    path       VARCHAR(50) NOT NULL 
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

CREATE TABLE userImage -- -- 유저 이미지 --
(
userImgeNum INT primary key auto_increment,
userImageName VARCHAR(20) NOT NULL,
userImageId VARCHAR(20) NOT NULL,
userImagePath VARCHAR(50) NOT NULL
);




































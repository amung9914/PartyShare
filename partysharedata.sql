
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

commit;

INSER



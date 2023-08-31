select * from member;
SELECT * FROM member WHERE mid = 'admin' AND mpw = 'admin';

show tables;
select * from joinmember;
drop table partydescription;
select * from partydescription;
select * from map;
commit;
desc partyboard_comment;
1039 1040 1041 1043
delete from party where pnum=1039;

select * from party; 
SELECT * FROM member;
SELECT * FROM report;
select * from wishlist;
select * from party;
select * from freeboard;
select * from freeboard_comment;
DESC report;
desc party;
delete from party where pnum = 5;
desc party; pContext

ALTER TABLE party MODIFY COLUMN pContext LONGTEXT;
SELECT * FROM party WHERE finish ='N' ;
update party set finish='N';
SELECT M.* FROM map M JOIN party USING (pnum) WHERE finish ='N' ORDER BY pnum DESC;

DELETE FROM freeboard;
DELETE FROM freeboard_comment;
DELETE FROM report;
SELECT * FROM freeboard_comment;

SELECT * FROM wishlist;
DESC freeboard;

SELECT * FROM partyboard WHERE pnum = 1;

INSERT INTO partyboard(category,pnum,title,content,writer,mnum) 
SELECT category,pnum,title,content,writer,mnum FROM partyboard WHERE pnum = 1;

SELECT * FROM party ORDER BY pNum DESC;
SELECT * FROM report;
SELECT * FROM member;

UPDATE member SET mBlackYN = 'Y' WHERE mid = 'kimjw987123';

INSERT INTO party(pName, host, sido, sigungu, address, detailAddress, startDate, endDate, pContext, description, category, partyImage1, partyImage2, partyImage3)
SELECT pName, host, sido, sigungu, address, detailAddress, startDate, endDate, pContext, description, category, partyImage1,partyImage2,partyImage3 from party;

SELECT * FROM map;
DELETE FROM map WHERE pNum = 1022;


-- 권한 table
CREATE TABLE validation_member_auth(
	mId VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    constraint fk_member_auth FOREIGN KEY(mId) 
    REFERENCES member(mId)
);

DESC validation_member_auth;

desc blacklist;
desc party;
DESC report;

DELETE FROM wishlist;
DROP TABLE location;
DELETE FROM member;
DELETE FROM party;
delete from map;
delete from partyboard;
delete from joinmember;
delete from chat;

INSERT INTO validation_member_auth
VALUES ('admin', 'ROLE_ADMIN');

select * from validation_member_auth;
SELECT * FROM freeboard;

ALTER TABLE freeboard ADD commentCount INT NULL DEFAULT 0;
ALTER TABLE freeboard DROP COLUMN commentCount;
DESC freeboard;

SELECT * FROM report;
DROP TABLE report;

CREATE TABLE report  -- -- 신고내역 --  
(
    no    		INT primary key auto_increment,  
    fromMid     VARCHAR(20)  NOT NULL,  
    toMid 		VARCHAR(20)  NOT NULL,
    date  		date NOT NULL,
    category   VARCHAR(20) NOT NULL,   -- 신고 카테고리 
    context    TEXT  NOT NULL,   -- 신고 내용
    bno INT,
    cno INT,
    FOREIGN KEY (bno) REFERENCES freeboard(bno)ON DELETE CASCADE,
	FOREIGN KEY (cno) REFERENCES freeboard_comment(cno)ON DELETE CASCADE,
	FOREIGN KEY (fromMid) REFERENCES member(mId) ON UPDATE CASCADE,
    FOREIGN KEY (toMid) REFERENCES member(mId) ON UPDATE CASCADE
);
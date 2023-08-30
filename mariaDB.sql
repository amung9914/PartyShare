select * from member;
SELECT * FROM member WHERE mid = 'admin' AND mpw = 'admin';

show tables;
select * from joinmember;

select * from map;

desc partyboard_comment;

select * from wishlist;
select * from party;
select * from freeboard;
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

DELETE FROM wishlist;
DROP TABLE location;
DELETE FROM member;
DELETE FROM party;

INSERT INTO validation_member_auth
VALUES ('admin', 'ROLE_ADMIN');



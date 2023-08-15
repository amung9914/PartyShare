select * from map;

select * from partyBoard;

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


delete from friend;

desc friend;

INSERT INTO partyBoard(category,pnum,title,context,mnick,date) 
SELECT category,pnum,title,context,mnick,date FROM partyBoard;

ALTER TABLE partyBoard
CHANGE COLUMN viewcnt viewcnt INT default 0;	

desc partyboard;

-- member 테이블 party 테이블 이미지 컬럼 수정
alter table member drop column profileImage;
alter table member modify column profileImageName varchar(256);
alter table party modify column partyImage1 varchar(256);
alter table party modify column partyImage2 varchar(256);
alter table party modify column partyImage3 varchar(256);

delete from party where pnum = 3;

select * from member;
desc joinmember;

select * from joinmember 

delete from joinmember where pnum = 3; 
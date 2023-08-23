-- 파티 게시판 수정
drop table partyboard;

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
	CONSTRAINT fk_partyboard_mnum
	FOREIGN KEY(mnum) REFERENCES member(mnum),
    CONSTRAINT fk_partyboard_pnum
	FOREIGN KEY(pnum) REFERENCES party(pnum)
);

desc partyboard;

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
	CONSTRAINT fk_partyboard_comment_bno FOREIGN KEY(bno) -- 참조무결성 추가
	REFERENCES partyboard(bno) ON DELETE CASCADE,
	CONSTRAINT fk_partyboard_comment_pnum		
	FOREIGN KEY(pnum) REFERENCES party(pnum)ON DELETE CASCADE,
	CONSTRAINT fk_partyboard_comment_mnick		
	FOREIGN KEY(mnick) REFERENCES member(mnick)ON DELETE CASCADE,
	CONSTRAINT fk_partyboard_comment_mid		
	FOREIGN KEY(mid) REFERENCES member(mid)ON DELETE CASCADE,
	INDEX(bno)									-- 인덱스 추가
);

-- 댓글 정보 가지고 올때 -> bno 검색하니까 index 설정하면 속도향상 가능
SELECT * FROM tbl_comment WHERE bno = 1;

SHOW INDEXES FROM tbl_comment;

-- 외래키 정보 확인
SELECT * FROM information_schema.REFERENTIAL_CONSTRAINTS
WHERE table_name = 'tbl_comment';

-- 댓글 삽입
INSERT INTO tbl_comment(bno,commentText,commentAuth)
VALUES(1, '1번 게시글의 댓글','최기근');

SELECT * FROM tbl_comment WHERE bno = 2;
SELECT * FROM tbl_board WHERE bno = 2;

INSERT INTO partyboard_comment(pnum,bno,commentText,mnick,mid)
(SELECT pnum,bno,commentText,mnick,mid FROM partyboard_comment);


-- 댓글 볼 때
SELECT * FROM partyboard_comment;
WHERE bno = 1 ORDER BY cno DESC
limit 0, 10;

desc notice;
select * from notice;
INSERT INTO notice (context) VALUES('test중입니다');

select * from partyboard_report;

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

alter table partyboard_comment add column reported char(1) default 'N';
alter table partyboard add column reported char(1) default 'N'; 

SELECT M.mid, p.* FROM partyBoard P, member M WHERE P.writer = M.mnick AND bno = 9 AND pnum = 1;

desc member profileImageName


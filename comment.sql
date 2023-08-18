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
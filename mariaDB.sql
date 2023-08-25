select * from member;


SELECT * FROM member WHERE mid = 'admin' AND mpw = 'admin';

show table;

select * from map;

select * from party;
delete from party where pnum = 5;

desc party; pContext

ALTER TABLE party MODIFY COLUMN pContext LONGTEXT;
SELECT * FROM party WHERE finish ='N' ;

SELECT M.* FROM map M JOIN party USING (pnum) WHERE finish ='N' ORDER BY pnum DESC;


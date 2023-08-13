select * from map;

select * from partyBoard;

INSERT INTO partyBoard(category,pnum,title,context,mnick,date) 
SELECT category,pnum,title,context,mnick,date FROM partyBoard;

ALTER TABLE partyBoard
CHANGE COLUMN viewcnt viewcnt INT default 0;	
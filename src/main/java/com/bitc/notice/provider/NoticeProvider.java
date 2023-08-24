package com.bitc.notice.provider;

import java.util.List;

import org.apache.ibatis.jdbc.SQL;

import com.bitc.member.vo.MemberVO;
import com.bitc.notice.vo.NoticeVO;



public class NoticeProvider {
	
	public String registTest(
		//	BoardVO
		//	board
			) {
		SQL sql = new SQL();
		sql.INSERT_INTO("re_tbl_board");
		sql.INTO_COLUMNS("title" , "content" , "writer" , "uno");
		sql.INTO_VALUES("#{title} , #{content}, #{writer} , #{uno}");
		
		
		String query = sql.toString();
		return query;
	}
	
	// INSERT INTO report (mId , date , content , no , readed) VALUES (1번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	// INSERT INTO report (mId , date , content , no , readed) VALUES (2번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	// INSERT INTO report (mId , date , content , no , readed) VALUES (3번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	// INSERT INTO report (mId , date , content , no , readed) VALUES (4번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	// INSERT INTO report (mId , date , content , no , readed) VALUES (5번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	// INSERT INTO report (mId , date , content , no , readed) VALUES (6번 , ㅇ , ㅇ , ㅇ ,ㅇ)
	/*
	INSERT INTO report (mId, date, content, no, readed) VALUES
	(1번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ'),
	(2번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ'),
	(3번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ'),
	(4번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ'),
	(5번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ'),
	(6번, 'ㅇ', 'ㅇ', 'ㅇ', 'ㅇ');
	*/
	public String insertPostAll(List<MemberVO> list, NoticeVO notice) {
		SQL sql = new SQL();
		int count = 1;
		String values = " VALUES ";
		System.out.println(values);
		sql.INSERT_INTO("notice"); 
		sql.INTO_COLUMNS("mId" , "context" );	
		for(MemberVO vo : list) {
			if(count != list.size()) {  //size가 5일때
				System.out.println("cnt="+count +"/ size=" +list.size());
			values += "(\""+vo.getMid()+"\","+ "\""+notice.getContext()+"\"),";
			}else {
				values += "(\""+vo.getMid()+"\","+ "\""+notice.getContext()+"\");";	
			}
			count += 1;
			
		}
		String query = sql.toString();
		query += values;
		System.out.println("중간체크:"+query);
		return query;
	}
	
	public String blackPost(String mId, NoticeVO vo) {
		SQL sql = new SQL();
		
		vo.setContext("회원님은 블랙리스트 처리되셨습니다");
		sql.INSERT_INTO("notice");
		sql.INTO_COLUMNS("mId","context");
		
		sql.INTO_VALUES("\""+mId+"\"", "\""+vo.getContext()+"\"");
		String query = sql.toString();
		System.out.println("블랙쿼리:" +query);
		return query;
	}
}

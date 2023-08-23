package com.bitc.partyBoard.provider;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.jdbc.SQL;

import com.bitc.common.utils.SearchCriteria;

public class PartyBoardQueryProvider {

	public String searchSelectSql(@Param("pnum")int pnum,@Param("cri")SearchCriteria cri) {
		SQL sql = new SQL();
		sql.SELECT("*");
		sql.FROM("partyBoard");
		
		getSearchWhere(cri,sql);

		sql.AND().WHERE("pnum = #{pnum}");
		sql.AND().WHERE("category != 'notice'");
		
		sql.ORDER_BY("origin DESC, seq ASC");
		sql.LIMIT(cri.getStartRow()+","+cri.getPerPageNum());
		String query = sql.toString();
		return query;
		
	}
	
	public void getSearchWhere(SearchCriteria cri,SQL sql) {
		String titleQuery = "title LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
		String contentQuery = "content LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
		String writerQuery = "writer LIKE CONCAT('%','"+cri.getKeyword()+"','%')";
		
		String type = cri.getSearchType();
		
		if(type != null
				&& !type.trim().equals("")
				&& !type.trim().equals("n")) {
			// searchType 존재시
			
			// t c w tc cw tcw
			if(type.contains("t")) {
				sql.OR().WHERE(titleQuery);
			}
			if(type.contains("c")) {
				sql.OR().WHERE(contentQuery);
			}
			if(type.contains("w")) {
				sql.OR().WHERE(writerQuery);
			}

		}
		
	}
}

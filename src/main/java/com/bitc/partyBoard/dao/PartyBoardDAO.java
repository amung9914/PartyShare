package com.bitc.partyBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.SearchCriteria;
import com.bitc.partyBoard.provider.PartyBoardQueryProvider;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyReportVO;


public interface PartyBoardDAO{
	
	// 게시글 작성
	@Insert("INSERT INTO partyBoard(category,pnum,title,content,writer,mnum) "
			+ "VALUES(#{category},#{pnum},#{title},#{content},#{writer},#{mnum})")
	void register(PartyBoardVO vo) throws Exception;
	
	@Update("UPDATE partyBoard SET origin = LAST_INSERT_ID() "
			+ "WHERE bno = LAST_INSERT_ID()")
	void updateOrigin() throws Exception;
	
	// 게시글 상세보기
	@Select("SELECT M.mid, p.* FROM partyBoard P, member M "
			+ "WHERE P.writer = M.mnick AND bno = #{bno} AND pnum = #{pnum}")
	PartyBoardVO read(PartyBoardVO vo)throws Exception;
	
	// 게시글 수정
	@Update("UPDATE partyBoard SET title = #{title} , "
			+ "content = #{content} , category = #{category} "
			+ " WHERE bno = #{bno} AND pnum = #{pnum}")
	int update(PartyBoardVO vo) throws Exception;
	
	// 게시글 삭제
	@Delete("DELETE FROM partyBoard WHERE bno = #{bno} AND pnum = #{pnum}")
	int delete(@Param("pnum")int pnum, @Param("bno")int bno) throws Exception;
	
	// 조회수 증가
	@Update("UPDATE partyBoard SET viewCnt = viewCnt + 1 "
			+ " WHERE bno = #{bno} AND pnum = #{pnum}")
	void updateCnt(@Param("bno")int bno, @Param("pnum")int pnum) throws Exception;
	
	

	// 전체 게시물 개수
	@Select("SELECT count(*) FROM partyBoard WHERE pnum = #{pnum}")
	int totalCount(int pnum) throws Exception;
	
	//검색 기능을 가진 게시글 목록
	@SelectProvider(type=PartyBoardQueryProvider.class, method="searchSelectSql")
	List<PartyBoardVO> listCriteria(@Param("pnum")int pnum,@Param("cri")SearchCriteria cri)throws Exception;

	// 답글 추가
	@Insert("INSERT INTO partyBoard (category,pnum,title,content,writer,mnum,origin,depth,seq) "
			+ "VALUES(#{category},#{pnum},#{title},#{content},#{writer},#{mnum},#{origin},#{depth},#{seq})")
	int registReply(PartyBoardVO board);

	/**
	 * 게시글 신고 
	 */
	@Insert("INSERT INTO partyboard_report (fromMid,toMid,category,context,pnum,bno) "
			+ "VALUES(#{fromMid},#{toMid},#{category},#{context},#{pnum},#{bno})")
	int report(PartyReportVO vo);
	
	
}












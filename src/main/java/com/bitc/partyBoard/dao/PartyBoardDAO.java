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


public interface PartyBoardDAO{
	
	// 게시글 작성
	@Insert("INSERT INTO partyBoard(category,pnum,title,content,writer,mnum) "
			+ "VALUES(#{category},#{pnum},#{title},#{content},#{writer},#{mnum})")
	void register(PartyBoardVO vo) throws Exception;
	
	@Update("UPDATE partyBoard SET origin = LAST_INSERT_ID() "
			+ "WHERE bno = LAST_INSERT_ID()")
	void updateOrigin() throws Exception;
	
	// 게시글 상세보기
	@Select("SELECT * FROM partyBoard WHERE bno = #{bno}")
	PartyBoardVO read(int bno)throws Exception;
	
	// 게시글 수정
	@Update("UPDATE partyBoard SET title = #{title} , "
			+ "content = #{content} , category = #{category} "
			+ " WHERE bno = #{bno}")
	int update(PartyBoardVO vo) throws Exception;
	
	// 게시글 삭제
	@Delete("DELETE FROM partyBoard WHERE bno = #{bno}")
	int delete(int bno) throws Exception;
	
	// 조회수 증가
	@Update("UPDATE partyBoard SET viewCnt = viewCnt + 1 "
			+ " WHERE bno = #{bno}")
	void updateCnt(int bno) throws Exception;
	
	// 전체 게시글 목록
	@Select("SELECT * FROM partyBoard ORDER BY bno DESC")
	List<PartyBoardVO> listAll()throws Exception;

	// 전체 게시물 개수
	@Select("SELECT count(*) FROM partyBoard")
	int totalCount() throws Exception;
	
	//검색 기능을 가진 게시글 목록
	@SelectProvider(type=PartyBoardQueryProvider.class, method="searchSelectSql")
	List<PartyBoardVO> listCriteria(@Param("pnum")int pnum,@Param("cri")SearchCriteria cri)throws Exception;

	// 답글 추가
	@Insert("INSERT INTO partyBoard (category,pnum,title,content,writer,mnum,origin,depth,seq) "
			+ "VALUES(#{category},#{pnum},#{title},#{content},#{writer},#{mnum},#{origin},#{depth},#{seq})")
	int registReply(PartyBoardVO board);
	
	
}












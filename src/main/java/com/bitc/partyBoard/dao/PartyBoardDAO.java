package com.bitc.partyBoard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.common.utils.Criteria;
import com.bitc.partyBoard.vo.PartyBoardVO;


public interface PartyBoardDAO{
	
	// 게시글 작성
	@Insert("INSERT INTO partyBoard(category,pnum,title,context,mnick,date) "
			+ "VALUES(#{category},#{pnum},#{title},#{context},#{mnick},NOW())")
	int create(PartyBoardVO vo) throws Exception;
	
	// 게시글 상세보기
	@Select("SELECT * FROM partyBoard WHERE bno = #{bno}")
	PartyBoardVO read(int bno)throws Exception;
	
	// 게시글 수정
	@Update("UPDATE partyBoard SET title = #{title} , "
			+ "context = #{context} , "
			+ "mnick = #{mnick} "
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
	
	// 페이징 처리된 게시물 목록
	@Select("SELECT * FROM partyBoard ORDER BY bno DESC "
			+ "limit #{startRow}, #{perPageNum}")
	List<PartyBoardVO> listCriteria(Criteria cri)throws Exception;
	
}












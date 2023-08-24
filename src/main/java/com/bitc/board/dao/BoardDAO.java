package com.bitc.board.dao;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;

public interface BoardDAO {
	/**
	 * board와 comment VO명 확인 <-- 
	 * --> 반환 메소드 추가 
	 * --> Service 추가 
	 * --> boardDetail(), commentDetail() 요청절에서 사용
	 * */
	
	/**
	 * 댓글VO 찾기
	 * */
	@Select("SELECT * FROM freeBoardComment WHERE cno = #{cno}")
	FreeBoardCommentVO freeBoardComment (int cno) throws Exception;
	
	/**
	 * 원본VO -> 원본 번호로
	 * */ 
	@Select("SELECT * FROM freeBoard WHERE bno = #{bno}")
	FreeBoardVO freeBoard(int bno) throws Exception;
	/**
	 * 원본VO -> 댓번으로
	 * */ 
	@Select ("SELECT * FROM freeBoard WHERE bno = " 
			+ " (SELECT bno FROM freeBoardComment WHERE cno = #{cno}) ")
	FreeBoardVO originalBoard (int cno) throws Exception;
	
	/**
	 * 파티댓글VO 찾기
	 * */
	@Select("SELECT * FROM partyBoard_Comment WHERE cno = #{cno} ")
	PartyCommentVO partyComment (int cno) throws Exception;
	
	/**
	 * 파티댓글VO -> 원본 번호로
	 * */
	@Select("SELECT * FROM partyBoard WHERE bno = #{bno}")
	PartyBoardVO partyBoard(int bno) throws Exception;
	
	/**
	 * 파티댓글VO -> 댓글 번호로
	 * */
	@Select("SELECT * FROM partyBoard WHERE bno = "
			+ " (SELECT bno FROM partyboard_comment  WHERE cno = #{cno})")
	PartyBoardVO originalPartyBoard(int cno) throws Exception;
	
	@Update("UPDATE freeBoard SET showBoard = 'N' WHERE bno = #{bno} ")
	void blindBoard(int bno) throws Exception;
	
	@Update("UPDATE freeBoardComment SET showBoard = 'N' WHERE cno = #{cno} ")
	void blindComment(int cno)throws Exception;
	
	@Update("UPDATE partyBoard SET showBoard = 'N' WHERE bno = #{bno}")
	void blindPartyBoard (int bno) throws Exception;
	
	@Update("UPDATE partyboard_comment SET showBoard ='N' WHERE bno = #{bno}")
	void blindPartyComment (int cno)throws Exception;
	
	
	
	/**
	 * partyBoardVO 
	 * partyBoardCommentVO 받아오기 
	 * */
//	@Select
	
}

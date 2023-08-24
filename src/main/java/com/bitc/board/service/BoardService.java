package com.bitc.board.service;

import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;

public interface BoardService {
	/**
	 * board와 comment VO명 확인 <-- 
	 * --> 반환 메소드 추가 
	 * --> Service 추가 
	 * --> boardDetail(), commentDetail() 요청절에서 사용
	 * */
	
	
	/**
	 * 자유게시판VO -> 원본 번호로
	 * */
	public FreeBoardVO freeBoard(int bno) throws Exception;
	
	/**
	 * 자유 게시판 댓글VO 찾기
	 * */
	public FreeBoardCommentVO freeBoardComment (int cno) throws Exception;
	/**
	 * partyBoardVO 
	 * partyBoardCommentVO 받아오기 
	 * */
	public FreeBoardVO originalBoard (int cno) throws Exception;
	
	/**
	 * 파티댓글VO 찾기
	 * */
	public PartyCommentVO partyComment (int cno) throws Exception;
	
	/**
	 * 파티댓글VO -> 원본 번호로
	 * */
	public PartyBoardVO partyBoard(int bno) throws Exception;
	
	/**
	 * 파티댓글VO -> 댓글 번호로
	 * */
	public PartyBoardVO originalPartyBoard(int cno) throws Exception;
	/**
	 * 자유게시글 블라인드
	 * */
	public void blindBoard(int bno) throws Exception;
	
	/**
	 * 자유게시글 댓글 블라인드
	 * */
	public void blindComment(int cno)throws Exception;
	
	/**
	 * 파티게시글 블라인드
	 * */
	public void blindPartyBoard (int bno) throws Exception;
	
	/**
	 * 파티게시글 댓글 블라인드
	 * */
	public void blindPartyComment (int cno)throws Exception;

}

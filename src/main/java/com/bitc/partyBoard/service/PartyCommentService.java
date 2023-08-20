package com.bitc.partyBoard.service;

import java.util.List;

import com.bitc.partyBoard.vo.PartyCommentDTO;
import com.bitc.partyBoard.vo.PartyCommentVO;

public interface PartyCommentService {

	/**
	 * 게시글 번호를 전달받아서
	 * bno값이 일치하는 댓글 리스트
	 */
	List<PartyCommentVO> listPage(PartyCommentDTO dto)throws Exception;
	
	/**
	 * 댓글 삽입
	 */
	PartyCommentVO insert(PartyCommentVO vo) throws Exception;
	
	/**
	 * 댓글 수정
	 */
	String update(PartyCommentVO vo) throws Exception;
	
	/**
	 * 댓글 삭제
	 */
	String delete(PartyCommentVO vo) throws Exception;
	
}

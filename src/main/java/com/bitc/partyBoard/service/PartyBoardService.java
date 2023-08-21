package com.bitc.partyBoard.service;

import java.util.List;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.common.utils.SearchCriteria;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyReportVO;

public interface PartyBoardService{
	
	/**
	 *  게시글 작성 
	 */
	void regist(PartyBoardVO board)throws Exception;
	
	/**
	 *  조회수 증가
	 */
	void updateCnt(int bno,int pnum)throws Exception;
	
	/**
	 *  게시글 상세보기
	 */
	PartyBoardVO read(PartyBoardVO board) throws Exception;
	
	
	/**
	 *  게시글 수정 - 성공 유무에 따라 메세지 전달
	 */
	String modify(PartyBoardVO board) throws Exception;
	
	/**
	 *  게시글 삭제 - 성공 유무에 따라 메세지 전달
	 */
	String remove(int pnum,int bno) throws Exception;
	
	/**
	 *  페이징 처리된 리스트 목록
	 */
	List<PartyBoardVO> listCriteria(int pnum,SearchCriteria cri)throws Exception;
	
	/**
	 *  페이징 정보 처리
	 */
	PageMaker getPageMaker(int pnum,Criteria cri)throws Exception;

	/**
	 * 답글 추가 처리
	 */
	void registReply(PartyBoardVO board) throws Exception ;
	
	/**
	 * 신고 처리
	 */
	String report(PartyReportVO vo) throws Exception;

	
}












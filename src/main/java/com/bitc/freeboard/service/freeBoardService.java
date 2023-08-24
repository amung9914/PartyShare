package com.bitc.freeboard.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.report.vo.ReportVO;

public interface freeBoardService {
	
	// 자유게시판 공지 글 목록 불러오기
	public List<FreeBoardVO> readFreeBoardNotice() throws Exception;
	
	// 자유게시판 글 목록 불러오기
	public List<FreeBoardVO> readFreeBoard(Criteria cri) throws Exception;
	
	// 페이징 정보 처리
	public PageMaker getPageMaker(Criteria cri, FreeBoardVO vo) throws Exception;
	
	// 자유게시판 글 작성하기
	public void freeBoardUpload(FreeBoardVO vo) throws Exception;
	
	// 자유게시판 글 조회수 증가
	public void updateFreeBoardCnt(HttpSession session, int bno) throws Exception;

	// 자유게시판 글 상세보기
	public FreeBoardVO readFreeBoardDetail(int bno) throws Exception;

	// 게시글 수정 - 성공 유무에 따라 메세지 전달
	public String freeBoardModify(FreeBoardVO vo) throws Exception;
	
	// 게시글 삭제 - 성공 유무에 따라 메세지 전달
	public String freeBoardRemove(int bno) throws Exception;
	
	// 게시글 검색
	public List<FreeBoardVO> getSearchList(Criteria cri, FreeBoardVO vo) throws Exception;
	
	// 신고하기
	public String report(ReportVO vo) throws Exception;

	// 자유게시판 답변글 등록
	void replyFreeBoard(FreeBoardVO vo) throws Exception;
}

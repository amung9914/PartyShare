package com.bitc.comment.service;

import java.util.List;

import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;

public interface commentService {
	
	// 댓글 삽입
	public String addComment(FreeBoardCommentVO vo) throws Exception;
	
	// 페이징 처리된 댓글 리스트
	public List<FreeBoardCommentVO> commentListPage(Criteria cri, int bno) throws Exception;
	
	// 댓글 페이징 블럭 정보
	public PageMaker getCommentPageMaker(Criteria cri, int bno) throws Exception;

	// 댓글 수정
	public String updateComment(FreeBoardCommentVO vo) throws Exception;

	// 댓글 삭제
	public String deleteComment(int cno) throws Exception;
	
}

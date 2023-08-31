package com.bitc.comment.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bitc.comment.dao.commentMapper;
import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;

@Service
public class commentServiceImpl implements commentService{

	@Autowired
	private commentMapper dao;

	@Override
	public String addComment(FreeBoardCommentVO vo) throws Exception {
		int result = dao.addComment(vo);
		return result == 1 ? "댓글 작성 완료" : "댓글 작성 실패";
	}
	
	@Override
	public void addCommentCount(int bno) throws Exception {
		dao.addCommentCount(bno);
	}
	
	@Override
	public List<FreeBoardCommentVO> commentListPage(Criteria cri, int bno) throws Exception {
		List<FreeBoardCommentVO> list = dao.commentListPage(cri, bno);
		List<FreeBoardCommentVO> newList = new ArrayList<>();
		
		for(FreeBoardCommentVO vo : list) {
			vo.setRegdateStr();
			newList.add(vo);
		}
		
		return newList;
	}
	
	@Override
	public PageMaker getCommentPageMaker(Criteria cri, int bno) throws Exception {
		int totalCount = dao.commentTotalCount(bno);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

	@Override
	public String updateComment(FreeBoardCommentVO vo) throws Exception {
		int result = dao.updateComment(vo);
		return result == 1 ? "댓글 수정 완료" : "댓글 수정 실패";
	}

	@Override
	public String deleteComment(int cno) throws Exception {
		int result = dao.deleteComment(cno);
		return result == 1 ? "댓글 삭제 완료" : "댓글 삭제 실패";
	}

	@Override
	public void deleteCommentCount(int bno) throws Exception {
		dao.deleteCommentCount(bno);
	}

	
}

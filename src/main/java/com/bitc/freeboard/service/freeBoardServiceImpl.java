package com.bitc.freeboard.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.freeboard.dao.freeBoardMapper;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.report.vo.ReportVO;

@Service
public class freeBoardServiceImpl implements freeBoardService{

	@Autowired
	private freeBoardMapper dao;

	@Override
	public List<FreeBoardVO> readFreeBoardNotice() throws Exception {
		return dao.readFreeBoardNotice();
	}
	
	@Override
	public List<FreeBoardVO> readFreeBoard(Criteria cri) throws Exception {
		// database에서 criteria 정보를 이용하여
		// 사용자가 요청한 페이지에 따라 게시글 목록 검색하여 전달
		return dao.readFreeBoard(cri);
	}
	
	@Override
	public PageMaker getPageMaker(Criteria cri, FreeBoardVO vo) throws Exception {
		// criteria 요청한 페이지 정보에 따라 페이징 블럭 정보를 저장하는 PageMaker 객체 반환
		int totalCount = 0;
		if(vo.getType() != null && vo.getType().equals("title")) {
			totalCount = dao.totalCountTitle(vo); 
		} else if(vo.getType() != null && vo.getType().equals("context")) {
			totalCount = dao.totalCountContext(vo); 
		} else if(vo.getType() != null && vo.getType().equals("mnick")) {
			totalCount = dao.totalCountWriter(vo); 
		} else {
			totalCount = dao.totalCount();
		}
		return new PageMaker(cri, totalCount);
	}
	
	@Transactional
	@Override
	public void freeBoardUpload(FreeBoardVO vo) throws Exception {
		dao.freeBoardUpload(vo);
		dao.updateOrigin();
	}

	@Override
	public void updateFreeBoardCnt(HttpSession session, int bno) throws Exception {
		Set<Integer> visitedPosts = (Set<Integer>) session.getAttribute("visitedPosts");
		
		if(visitedPosts == null) {
			visitedPosts = new HashSet<>();
			session.setAttribute("visitedPosts", visitedPosts);
		}
		
		if(!visitedPosts.contains(bno)) {
			dao.updateFreeBoardCnt(bno);
			visitedPosts.add(bno);
		}
	}

	@Override
	public FreeBoardVO readFreeBoardDetail(int bno) throws Exception {
		return dao.readFreeBoardDetail(bno);
	}

	@Override
	public String freeBoardModify(FreeBoardVO vo) throws Exception {
		int result = dao.freeBoardModify(vo);
		return (result != 0) ? "수정 완료" : "수정 실패";
	}

	@Override
	public String freeBoardRemove(int bno) throws Exception {
		int result = dao.freeBoardRemove(bno);
		return (result != 0) ? "삭제 완료" : "삭제 실패";
	}

	@Override
	public List<FreeBoardVO> getSearchList(Criteria cri, FreeBoardVO vo) throws Exception {
		List<FreeBoardVO> list = null;
		if(vo.getType() != null && vo.getType().equals("title")) {
			list = dao.getSearchListTitle(cri, vo); 
		} else if(vo.getType() != null && vo.getType().equals("context")) {
			list = dao.getSearchListContext(cri, vo); 
		} else if(vo.getType() != null && vo.getType().equals("mnick")) {
			list = dao.getSearchListWriter(cri, vo); 
		}	
		return list;
	}

	@Override
	public String report(ReportVO vo) throws Exception {
		int result = 0;
		
		if(vo.getBno() == 0) {
			result = dao.reportFreeBoardComment(vo);
		} else if(vo.getCno() == 0) {
			result = dao.reportFreeBoard(vo);
		}
		
		return result == 1 ? "신고 완료" : "신고 실패";
	}

	@Override
	public void replyFreeBoard(FreeBoardVO vo) throws Exception {
		// origin, depth, seq
		// 답변을 달려는 원본 글보다 아래쪽에 배치된 글들 seq(정렬) 값 수정
		dao.updateReply(vo);
		
		vo.setDepth(vo.getDepth() + 1);
		vo.setSeq(vo.getSeq() + 1);
		
		// 답변글 등록
		dao.replyRegister(vo);
	}

	
}

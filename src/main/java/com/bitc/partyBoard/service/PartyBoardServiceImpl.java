package com.bitc.partyBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.common.utils.SearchCriteria;
import com.bitc.partyBoard.dao.PartyBoardDAO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyReportVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PartyBoardServiceImpl implements PartyBoardService {

	private final PartyBoardDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
		private String getResult(int result) {
			return result == 1?"SUCCESS":"FAILED";
		}
	
	@Transactional
	@Override
	public void regist(PartyBoardVO board) throws Exception {
		dao.register(board);
		// origin column 값을 등록된 게시글 번호로 수정
		dao.updateOrigin();
	}

	@Override
	public void updateCnt(int bno,int pnum) throws Exception {
		dao.updateCnt(bno,pnum);
	}

	@Override
	public PartyBoardVO read(PartyBoardVO board) throws Exception {
		return dao.read(board);
	}


	@Override
	public String modify(PartyBoardVO board) throws Exception {
		return getResult(dao.update(board));
	}

	@Override
	public String remove(int pnum,int bno) throws Exception {
		return getResult(dao.delete(pnum,bno));
	}

	@Override
	public List<PartyBoardVO> listCriteria(int pnum,SearchCriteria cri) throws Exception {
		// database에서 criteria 정보를 이용하여
		// 사용자가 요청한 페이지에 따라 게시글 목록 검색하여 전달
		return dao.listCriteria(pnum,cri);
	}
	
	@Override
	public List<PartyBoardVO> noticeList(int pnum) {
		return dao.noticeList(pnum);
	}

	@Override
	public PageMaker getPageMaker(int pnum, Criteria cri) throws Exception {
		// criteria 요청한 페이지 정보에 따라 페이징 블럭 정보를 저장하는
		// PageMaker 객체 반환
		int totalCount = dao.totalCount(pnum);
		return new PageMaker(cri,totalCount);
	}
	@Transactional
	@Override
	public void registReply(PartyBoardVO board)throws Exception  {
		// origin, depth, seq
		// 답변을 달려는 원본 글보다 아래쪽에 배치된 글들 seq(정렬) 값 수정
		dao.updateReply(board);
		
		board.setDepth(board.getDepth() + 1);
		board.setSeq(board.getSeq() + 1);
		dao.registReply(board);
	}

	@Override
	public String report(PartyReportVO vo) throws Exception {
		return getResult(dao.report(vo));
	}

	

}

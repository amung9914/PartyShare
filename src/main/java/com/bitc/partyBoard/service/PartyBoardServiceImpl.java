package com.bitc.partyBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.common.utils.SearchCriteria;
import com.bitc.partyBoard.dao.PartyBoardDAO;
import com.bitc.partyBoard.vo.PartyBoardVO;

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
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public PartyBoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}

	@Override
	public List<PartyBoardVO> listAll() throws Exception {
		return null;
	}

	@Override
	public String modify(PartyBoardVO board) throws Exception {
		return getResult(dao.update(board));
	}

	@Override
	public String remove(int bno) throws Exception {
		return getResult(dao.delete(bno));
	}

	@Override
	public List<PartyBoardVO> listCriteria(int pnum,SearchCriteria cri) throws Exception {
		// database에서 criteria 정보를 이용하여
		// 사용자가 요청한 페이지에 따라 게시글 목록 검색하여 전달
		return dao.listCriteria(pnum,cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		// criteria 요청한 페이지 정보에 따라 페이징 블럭 정보를 저장하는
		// PageMaker 객체 반환
		int totalCount = dao.totalCount();
		return new PageMaker(cri,totalCount);
	}
	
	@Transactional
	@Override
	public void registReply(PartyBoardVO board)throws Exception  {
		dao.registReply(board);
	}

}

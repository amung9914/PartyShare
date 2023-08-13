package com.bitc.partyshare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.partyshare.dao.PartyBoardDAO;
import com.bitc.partyshare.utils.Criteria;
import com.bitc.partyshare.utils.PageMaker;
import com.bitc.partyshare.vo.PartyBoardVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PartyBoardServiceImpl implements PartyBoardService {

	private final PartyBoardDAO dao;
	
	@Override
	public String regist(PartyBoardVO board) throws Exception {
		int result = dao.create(board);
		String message = (result !=0) ? "SUCCESS" : "FAILED";
		return message;
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
		int result = dao.update(board);
		
		return (result != 0)?"SUCCESS":"FAILED";
	}

	@Override
	public String remove(int bno) throws Exception {
		
		return dao.delete(bno) == 1 ? "SUCCESS":"FAILED";
	}

	@Override
	public List<PartyBoardVO> listCriteria(Criteria cri) throws Exception {
		// database에서 criteria 정보를 이용하여
		// 사용자가 요청한 페이지에 따라 게시글 목록 검색하여 전달
		return dao.listCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		// criteria 요청한 페이지 정보에 따라 페이징 블럭 정보를 저장하는
		// PageMaker 객체 반환
		int totalCount = dao.totalCount();
		return new PageMaker(cri,totalCount);
	}

}

package com.bitc.partyBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.partyBoard.dao.PartyCommentDAO;
import com.bitc.partyBoard.vo.PartyCommentDTO;
import com.bitc.partyBoard.vo.PartyCommentVO;
import com.bitc.partyBoard.vo.PartyReportVO;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class PartyCommentServiceImpl implements PartyCommentService {

	private final PartyCommentDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SUCCESS":"FAILED";
	}
	
	@Override
	public List<PartyCommentVO> listPage(PartyCommentDTO dto) throws Exception {
		return dao.listPage(dto);
	}
	
	@Transactional
	@Override
	public String insert(PartyCommentVO vo) throws Exception {
		
		return getResult(dao.insert(vo)); 
	}

	@Override
	public String update(PartyCommentVO vo) throws Exception {
		return getResult(dao.update(vo));
	}

	@Override
	public String delete(PartyCommentVO vo) throws Exception {
		return getResult(dao.delete(vo));
	}

	@Override
	public PageMaker getPageMaker(PartyCommentDTO dto) throws Exception {
		int totalCount = dao.totalCount(dto.getBno(),dto.getPnum());
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(dto.getCri());
		pageMaker.setDisplayPageNum(5);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

	@Override
	public PartyCommentVO read(PartyCommentVO vo) throws Exception {
		return dao.read(vo);
	}

	@Override
	public String report(PartyReportVO vo) {
		return getResult(dao.report(vo));
	}
	


	

}

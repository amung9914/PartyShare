package com.bitc.partyBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bitc.partyBoard.dao.PartyCommentDAO;
import com.bitc.partyBoard.vo.PartyCommentDTO;
import com.bitc.partyBoard.vo.PartyCommentVO;

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
	public PartyCommentVO insert(PartyCommentVO vo) throws Exception {
		dao.insert(vo);
		return dao.read();
	}

	@Override
	public String update(PartyCommentVO vo) throws Exception {
		return getResult(dao.update(vo));
	}

	@Override
	public String delete(PartyCommentVO vo) throws Exception {
		return getResult(dao.delete(vo));
	}
	


	

}

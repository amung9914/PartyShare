package com.bitc.partyshare.service;

import org.springframework.stereotype.Service;

import com.bitc.partyshare.dao.MemberDAO;
import com.bitc.partyshare.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	
	private final MemberDAO dao; 
	
	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		return dao.login(vo);
	}

}

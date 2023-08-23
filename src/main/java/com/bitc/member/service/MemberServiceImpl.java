package com.bitc.member.service;

import org.springframework.stereotype.Service;

import com.bitc.member.dao.MemberDAO;
import com.bitc.member.vo.MemberVO;

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

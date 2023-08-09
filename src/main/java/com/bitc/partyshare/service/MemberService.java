package com.bitc.partyshare.service;

import com.bitc.partyshare.vo.MemberVO;

public interface MemberService {

	
	/**
	 * 로그인
	 */
	MemberVO login(MemberVO vo) throws Exception;
}

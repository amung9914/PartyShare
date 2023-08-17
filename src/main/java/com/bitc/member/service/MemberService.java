package com.bitc.member.service;

import com.bitc.member.vo.MemberVO;

public interface MemberService {

	
	/**
	 * 로그인
	 */
	MemberVO login(MemberVO vo) throws Exception;
}

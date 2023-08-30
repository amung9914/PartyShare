package com.bitc.login.service;

import com.bitc.member.vo.MemberVO;

public interface JoinService {
	
	// 회원가입
	String Join(MemberVO vo) throws Exception;
	
}

package com.bitc.login.service;

import javax.servlet.http.HttpSession;

import com.bitc.login.vo.LoginDTO;
import com.bitc.login.vo.MemberVO;

public interface JoinService {
	
	// 회원가입
	String Join(MemberVO vo) throws Exception;
	
	// 로그인
	String login(LoginDTO dto, HttpSession session) throws Exception;
	


}

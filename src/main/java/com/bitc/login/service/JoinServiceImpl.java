package com.bitc.login.service;

import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.bitc.login.dao.JoinDAO;
import com.bitc.login.vo.LoginDTO;
import com.bitc.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JoinServiceImpl implements JoinService{
	
	// 의존성 주입?
	private final JoinDAO dao;
	private final PasswordEncoder passwordEncoder;

	@Override
	public String Join(MemberVO vo) throws Exception {
		String pw = vo.getMpw();
		vo.setMpw(passwordEncoder.encode(pw));
		int result = dao.join(vo);
		return getResult(result);
	}
	
	private String getResult(int result) {
		return result ==1 ? "성공" : "실패";
	}
	
	/*
	 * @Override public String loginCheck(String mId, String mPw) throws Exception{
	 * MemberVO m = dao.loginCheck(new MemberVO(mId,mPw)); if(m != null) {
	 * 
	 * }else {
	 * 
	 * } return null; }
	 */

	/*
	 * @Override public boolean isIdDuplicated(String mId) { int count =
	 * dao.joinCheck(mId); return count > 0; }
	 */
}

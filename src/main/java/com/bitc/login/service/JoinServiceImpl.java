package com.bitc.login.service;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.bitc.login.dao.JoinDAO;
import com.bitc.login.vo.LoginDTO;
import com.bitc.login.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JoinServiceImpl implements JoinService{
	
	// 의존성 주입?
	private final JoinDAO dao;

	@Override
	public String Join(MemberVO vo) throws Exception {
		System.out.println(vo);
		
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
	@Override
	public String login(LoginDTO dto, HttpSession session) throws Exception {
			MemberVO m = dao.loginCheck(dto);
			session.setAttribute("loginMember", m);
			if(m != null) {
				System.out.println(m);
				System.out.println(m.getMBlackYN());
				if(m.getMBlackYN().equals("Y")) {	
					return "blackList";
				}
				return "loginSuccess";
			}
			return "loginFailed";
			
	}


}

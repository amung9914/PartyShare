package com.bitc.common.security.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.bitc.login.dao.JoinDAO;
import com.bitc.member.vo.MemberVO;

public class CustomUserDetailsService implements UserDetailsService {
// 로그인페이지에서 인증정보 확인하는 클래스
	
	@Autowired
	JoinDAO dao;

	// 여기서 username은 u_id
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = null;
		try {
			vo = dao.getMemberById(username);
			if (vo != null) {
				// 이 사용자가 가지고 있는 권한 정보를 가져온다.
				vo.setAuthList(dao.getAuthList(username));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// return 한 사용자 정보를 이용하여 비밀번호를 비교
		return vo == null ? null : new CustomUser(vo);
	}

}

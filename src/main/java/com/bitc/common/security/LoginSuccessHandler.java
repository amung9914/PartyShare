package com.bitc.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.bitc.common.security.user.CustomUser;
import com.bitc.member.vo.MemberVO;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		CustomUser user = (CustomUser) auth.getPrincipal(); // 인가완료된 사용자 정보 가져옴, ID정보, 권한정보만 확인 가능
		MemberVO vo = user.getMember(); //CustomUser에 등록시켜놓은 ValidationMemberVO member정보 확인 가능
		request.getSession().setAttribute("loginMember", vo);
		String context = request.getContextPath();
		response.sendRedirect(context);

	}

}

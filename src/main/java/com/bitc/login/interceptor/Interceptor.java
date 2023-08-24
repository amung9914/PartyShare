package com.bitc.login.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bitc.login.vo.LoginDTO;
import com.bitc.member.vo.MemberVO;


public class Interceptor implements HandlerInterceptor{
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception{
		System.out.println(request.getParameter("cookie"));
		System.out.println("interceptor pre");
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") != null) {
			session.removeAttribute("loginMember");
		}
		System.out.println("안옴");
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception{
		System.out.println("interceptor post");
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
		ModelMap modelObj = modelAndView.getModelMap();
		LoginDTO dto = (LoginDTO)modelObj.get("loginDTO");
		if(loginMember != null ) {
			if(dto.isCookie()) {
				Cookie cookie = new Cookie("signInCookie",loginMember.getMid());
				
				cookie.setPath("/");
				cookie.setMaxAge(60 * 60 * 24 * 15);
				response.addCookie(cookie);
			}
		}
	}
	
	
}

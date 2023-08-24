package com.bitc.common.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitc.member.service.MemberService;
import com.bitc.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Controller
public class HomeController {

	private final MemberService ms;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
		
		/*	
		// test용 로그인 수행
		@PostMapping("login")
		public String login(MemberVO vo, HttpSession session) {
			MemberVO loginMember = null;
			try {
				loginMember = ms.login(vo);
			} catch (Exception e) {
				e.printStackTrace();
			} //로그인 서비스 연결
			session.setAttribute("loginMember", loginMember);
			return "redirect:/account"; // get으로 mapping으로 감
		}	
		
*/
		// 계정관리 메뉴로 이동
		@GetMapping("account")
		public void account() {}
		
}

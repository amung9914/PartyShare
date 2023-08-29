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
	
	    //개인정보 처리 방침으로 이동
		@GetMapping("policy")
		public String policy() {
			return "common/policy";
		}
		
		//이용약관으로 이동
		@GetMapping("policy2")
		public String policy2() {
			return "common/policy2";
		}
	
		// 계정관리 메뉴로 이동
		@GetMapping("/user/account")
		public String account() {
			return "member/account";
		}
		// 회사세부정보 메뉴로 이동
		@GetMapping("infomation")
		public String infomation() {
			return "common/infomation";
		}
		
}

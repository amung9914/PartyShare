package com.bitc.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
//@RequestMapping("/go")
public class MoveController {
	//header.add("Content-Type","text/plain;charset=utf-8");
	/**
	 * 로그인 유저가 관리자일 때만 버튼 출력 // 위치 : header
	 * */
	

	@GetMapping("admin/notice")
	public String notice() {
		
		return "/admin/admin_notice";
	}
	
	@GetMapping("home")
	public String home() {
		return "redirect:/project";
	}
	
	@GetMapping("admin/user_list")
	public String user_list() {
		return "admin/user_list";
	}
	
	@GetMapping("search/modifySearchOpt")
	public String modifyCategory() {
		return "/admin/modifySearchOpt";
	}
	
	@GetMapping("report/admin_report")
	public String admin_report() {
		return "admin/admin_report";
	}
	

	@GetMapping("admin/admin")
	public String admin() {
		return "/admin/admin";
	}
	
	@GetMapping("admin/admin_notice")
	public String adminNotice() {
	//	System.out.println("호출");
		return "/admin/admin_notice";
	}
	
	@GetMapping("go")
 	public String go() {
 		System.out.println("ㄱㄷㄱ");
 		return "redirect:/admin/go";
 	}
 	@GetMapping("/admin/go")
 	public String gogo() {
 		return "/admin/start";
 	}
 	
 	@GetMapping("member/post")
 	public String post() {
		return "/member/post";
 	}
 	
 	@GetMapping("member/report")
	public String report() {
		return "member/report";
	}
 	

	

	
	
		
		
	
	
	
	
}

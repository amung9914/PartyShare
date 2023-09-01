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
	
	@GetMapping("admin/modifySearchOpt")
	public String modifyCategory() {
		return "/admin/modifySearchOpt";
	}
	
	@GetMapping("admin/admin_report")
	public String admin_report() {
		return "admin/admin_report";
	}
	

	@GetMapping("admin/admin")
	public String admin() {
		return "/admin/admin";
	}
	
	@GetMapping("admin/admin_notice")
	public String adminNotice() {
		return "/admin/admin_notice";
	}
	
	@GetMapping("go")
 	public String go() {
 		return "redirect:/admin/go";
 	}
 	@GetMapping("/admin/go")
 	public String gogo() {
 		return "/admin/start";
 	}
 	
 	@GetMapping("user/post")
 	public String post() {
		return "/member/post";
 	}
 	
 	@GetMapping("user/report")
	public String report() {
		return "member/report";
	}
 	

 	@GetMapping("user/bonpost")
	public String bon_post() {
 		System.out.println("bon_post여기까지 왔어요");
		return "member/bonpost";
	}
	

	
	
		
		
	
	
	
	
}

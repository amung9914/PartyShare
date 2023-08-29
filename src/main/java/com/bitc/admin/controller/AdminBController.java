package com.bitc.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.bitc.admin.service.AdminService;
import com.bitc.member.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminBController {
	
	private final AdminService as;
	
	@GetMapping("/blacklist")
    public String blackList(Model model) throws Exception {
        List<MemberVO> blackMembers = as.blackId();
        model.addAttribute("blackMembers", blackMembers);
        return "admin/admin_blacklist"; 
 	}
	@PostMapping("/unblock")
	public String unblock(Model model) throws Exception{
		List<MemberVO> unblock = as.unblock();
		model.addAttribute("unblock", unblock);
		return "admin/admin_blacklist";
	}
}

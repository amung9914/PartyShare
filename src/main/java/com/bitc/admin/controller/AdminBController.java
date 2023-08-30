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
	
	@GetMapping("/admin/blacklist")
    public String blackList(Model model) {
        List<MemberVO> blackMembers = null;

        try {
			blackMembers = as.blackId();
		} catch (Exception e) {
			e.printStackTrace();
		}
        System.out.println(blackMembers);
        model.addAttribute("blackMembers", blackMembers);
        return "admin/admin_blacklist"; 
 	}
	@PostMapping("/admin/unblock")
	public String unblock(Model model, String mid) {
		
		List<MemberVO> unblock = null;
		try {
			unblock = as.unblock(mid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("unblock", unblock);
		return "redirect:/blacklist";
	}
}

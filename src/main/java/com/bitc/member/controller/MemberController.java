package com.bitc.member.controller;

import java.io.File;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.service.MemberService;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {
	
	private final MemberService ms;
	
	private final String uploadDir;
	private final ServletContext context;	
	private String realPath;
	
	@PostConstruct
	public void init() {
		realPath = context.getRealPath(File.separator+uploadDir);
		File file = new File(realPath);
		if(!file.exists()) {
			file.mkdirs();
			System.out.println("데렉토리 생성완료");
		}
	}
	
	
	// 개인정보 수정 페이지 이동
	@GetMapping("/profileModify")
	public String profileModify(Model model, HttpSession session, String page) {
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		List<PartyVO> list = null;
		if(page == null) {
			page = "1";
		}
		Criteria cri = new Criteria(Integer.parseInt(page), 5);
		int joinCnt = 0;
		
		try {
			// 참여했던 파티 목록
			list = ms.joinPartyList(member.getMnum(), cri);
			// 파티 참여 횟수
			joinCnt = ms.joinCnt(member.getMnum());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		PageMaker pm = new PageMaker(cri, joinCnt);
		model.addAttribute("joinCnt", joinCnt);
		model.addAttribute("joinPartyList", list);
		model.addAttribute("pm", pm);
		return "profileModify";
	}
	
	// 개인 정보 수정 요청
	@PostMapping("/modify")
	public String modifyMember(MemberVO member, HttpSession session) {
		try {
			ms.modifyMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("loginMember", member);
		return "redirect:profileModify";
	}
	
}

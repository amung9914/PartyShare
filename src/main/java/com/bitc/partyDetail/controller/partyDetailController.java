package com.bitc.partyDetail.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.member.vo.MemberVO;
import com.bitc.party.vo.PartyVO;
import com.bitc.partyDetail.service.partyDetailService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/partyDetail/*")
@RequiredArgsConstructor
public class partyDetailController {
	
	private final partyDetailService ps;
	
	@GetMapping("/detailOfParty")
	public void detailOfParty(HttpSession session, HttpServletRequest request, Model model) {
		
		// readParty와 readMember 메서드의 매개변수로 사용될 파티번호
		String sPnum = request.getParameter("pNum");
		int pNum = Integer.parseInt(sPnum);
		
		try {
			PartyVO vo = ps.readParty(pNum);
			int NumberOfJoinMember = ps.NumberOfJoinMember(pNum);
			ps.increaseView(session, pNum);
			double[] genderPercent = ps.readGenderPercent(pNum);
			double[] joinCntPercent = ps.readJoinCntPercent(pNum);
			double[] agePercent = ps.readAgePercent(pNum);
			double[] location = ps.readLocation(pNum);
			
			model.addAttribute("vo", vo);
			
			// 해당 파티의 파티원 수가 1명 이상이어야 화면에 통계자료 표시 
			if(NumberOfJoinMember != 0) {
				model.addAttribute("genderPercent", genderPercent);
				model.addAttribute("joinCntPercent", joinCntPercent);
				model.addAttribute("agePercent", agePercent);
				model.addAttribute("isEmpty", false);
			}else {
				model.addAttribute("isEmpty", true);
			}
			
			model.addAttribute("location", location);
		} catch (Exception e) {}
	}
	
	@GetMapping("/bookingParty")
	public String bookingParty(HttpServletRequest request, Model model) {
		
		// readParty 메서드의 매개변수로 사용될 파티번호
		String sPnum = request.getParameter("pNum");
		int pNum = Integer.parseInt(sPnum);
		
		try {
			PartyVO vo = ps.readParty(pNum);

			model.addAttribute("vo", vo);
			
			// 파티 시작날짜와 종료날짜가 일치하면 시작날짜만 전송, 다르면 모두 전송
			if(vo.getFormatStartDate().equals(vo.getFormatEndDate())) {
				model.addAttribute("startDate", vo.getFormatStartDate());
			}else {
				model.addAttribute("startDate", vo.getFormatStartDate());
				model.addAttribute("endDate", vo.getFormatEndDate());
			}
			
		} catch (Exception e) {}
		
		return "partyDetail/bookingParty";
	}
	
	@PostMapping("/bookingComplete")
	public String bookingComplete(RedirectAttributes rttr, HttpSession session, HttpServletRequest request) {
		
		String sPnum = request.getParameter("pNum");
		int pNum = Integer.parseInt(sPnum);
		
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		
		try {
			int result = ps.findJoinMember(pNum, member.getMnum());
			if(result == 0) {
				ps.joinMember(pNum, member.getMnum());
				ps.increaseJoinCnt(member.getMnum());
				rttr.addFlashAttribute("result", "파티 참여가 완료되었습니다.");
			}else {
				rttr.addFlashAttribute("result", "이미 참여한 파티입니다.");
			}
		} catch (Exception e) {}
		
		return "redirect:detailOfParty?pNum=" + pNum;
	}
	
	
}

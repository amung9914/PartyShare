package com.bitc.partyshare.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.partyshare.service.MapService;
import com.bitc.partyshare.service.MemberService;
import com.bitc.partyshare.service.PartyService;
import com.bitc.partyshare.vo.MapVO;
import com.bitc.partyshare.vo.MemberVO;
import com.bitc.partyshare.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class PartyController {

	private final MemberService ms;
	private final PartyService ps;
	private final MapService maps;
	
	// test용 로그인 페이지
	@GetMapping("login")
	public void login() {}
		
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
	
	
	// 계정관리 메뉴로 이동
	@GetMapping("account")
	public void account() {}
	
	// 내가 개설한 파티 리스트 페이지 이동
	@GetMapping("hostingList")
	public String partyHost(HttpSession session, Model model) {
		//model에 담아서 주기
		List<PartyVO> list = null;
		try {
			list = ps.HostingList(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		return "/party/hostingList";
	}
	
	// 파티관리 페이지
	@GetMapping("partyHost")
	public String partyHost(int pnum,Model model) {
		PartyVO vo = null;
		try {
			vo = ps.read(pnum,model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("party",vo);
		return "party/partyHost";
	}
	
	@GetMapping("updateParty")
	public String updateParty(int pnum,Model model) {
		PartyVO vo = null;
		MapVO map = null;
		try {
			vo = ps.read(pnum,model);
			map = maps.readLocation(pnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("party",vo);
		model.addAttribute("map", map);
		return "party/updateParty";
	}
	
	// mapVO, partyVO 수정처리
	@PostMapping("updateParty")
	public String updateSubmit(
			MapVO map, PartyVO party, RedirectAttributes rttr) {
		String result = "FAILED";
		String result1 = null;
		String result2 = null;
		try {
			result1 = maps.updateLocation(map);
			result2 = ps.update(party);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(result1.equals("SECCESS") && result1.equals(result2)) {
			result = "SUCCESS";
		}
		rttr.addFlashAttribute("result",result);
		rttr.addAttribute("pnum",party.getPnum());
		return "redirect:/partyHost"; 
	}
	
	
	
	// 참여중인 파티 페이지 이동
	@GetMapping("myParty")
	public String myParty(HttpSession session, Model model) {
		//model에 담아서 주기
				List<PartyVO> list = null;
				try {
					list = ps.myPartyList(session);
				} catch (Exception e) {
					e.printStackTrace();
				}
				model.addAttribute("list",list);
		return "/party/myPartyList";
	}
	
	// partyDetail 페이지
	@GetMapping("partyDetail")
	public String partyDetail(String pnum,Model model) {
		model.addAttribute("pnum",pnum);
		return "party/partyDetail";
	}
}


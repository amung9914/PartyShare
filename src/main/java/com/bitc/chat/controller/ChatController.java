package com.bitc.chat.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.chat.service.ChatService;
import com.bitc.chat.vo.ChatVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.service.PartyService;
import com.bitc.party.vo.PartyVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatController {
	
	private final ChatService sc;
	private final PartyService ps;
	
	@RequestMapping("/chat")
    public ModelAndView enterChat(@RequestParam int pnum, ModelAndView mav, HttpSession session, RedirectAttributes rttr) {
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		
		List<ChatVO> firstList = null;
		List<MemberVO> joinMemberList = null;
		PartyVO party= null;
		
		try {
			joinMemberList = ps.getJoinPartyMemberList(pnum);
			if(!joinMemberList.contains(member)) {
				String message = "파티 맴버만 입장할 수 있습니다.";
				rttr.addFlashAttribute("message", message);
				mav.setViewName("redirect:/partyDetail/detailOfParty?pNum="+pnum);
				return mav;
			}
			firstList = sc.selectFirstChatList(pnum);
			party = ps.read(pnum);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		mav.addObject("party",party);
		mav.addObject("firstList",firstList);
		mav.addObject("joinMemberList", joinMemberList);
		mav.setViewName("chat");
    	return mav;
    }
	
	
	@GetMapping("/chatList")
	@ResponseBody
	public List<ChatVO> selectChatList(@RequestParam int pnum, @RequestParam int endNo) {
		List<ChatVO> list = null;
		try {
			list = sc.selectChatList(pnum, endNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
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
	
	/**
	 * 채팅 창 입장 
	 */
	@RequestMapping("/user/chat")
    public ModelAndView enterChat(@RequestParam int pnum, ModelAndView mav, HttpSession session, RedirectAttributes rttr) {
		MemberVO member = (MemberVO) session.getAttribute("loginMember");
		
		// 입장시 출력될 채팅 리스트
		List<ChatVO> firstList = null;
		
		// 파티 맴버 목록 
		List<MemberVO> joinMemberList = null;
		PartyVO party= null;
		
		try {
			// 파티 맴버가 아닐 시 채팅 창 입장 불가
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
		mav.setViewName("party/chat");
    	return mav;
    }
	
	/**
	 * 이전 채팅 목록 가져오기 
	 * @param pnum - 채팅 목록을 가져올 파티 번호
	 * @param endNo - 현재 출력되고 있는 마지막 채팅번호
	 * @return
	 */
	@GetMapping("/user/chatList")
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
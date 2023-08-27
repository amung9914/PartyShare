package com.bitc.friend.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitc.friend.service.FriendService;
import com.bitc.friend.vo.FriendVO;

import lombok.RequiredArgsConstructor;

@RequestMapping("/friend")
@RequiredArgsConstructor
@Controller
public class FriendController {

	private final FriendService fs;
	
	// 친구 목록 페이지 
	@GetMapping("")
	public String friend(HttpSession session, Model model) throws Exception {
		List<FriendVO> list = null;
			list = fs.friendList(session);
		model.addAttribute("list",list);
		model.addAttribute("requestList",fs.requestList(session)); //친구 요청 보낸 목록 전달
		model.addAttribute("responseList",fs.responseList(session)); // 친구요청받은 목록 전달
		return "friend/friendList";
	}
	
	/**
	 *	친구요청보낸목록 
	 */
	/*
	@GetMapping("/requestList")
	public String requestList(HttpSession session, Model model){
		List<FriendVO> list = null;
		try {
			list = fs.requestList(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		return "friend/requestList";
	}
	*/
	
	/**
	 *	친구요청받은목록 
	 */
	/*
	@GetMapping("/responseList")
	public String responseList(HttpSession session, Model model){
		List<FriendVO> list = null;
		try {
			list = fs.responseList(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list",list);
		return "friend/responseList";
	}
	*/

}

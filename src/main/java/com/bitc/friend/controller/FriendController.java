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

@RequestMapping("/user/friend")
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
	

}

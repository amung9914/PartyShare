package com.bitc.partyshare.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitc.partyshare.service.MapService;

import lombok.RequiredArgsConstructor;

@PropertySource("classpath:api.properties")
@RequiredArgsConstructor
@Controller
public class HomeController {

	private final MapService ms;
	@Value("${kakao.key}")
	private String apiKey;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
	//주소등록페이지
	@GetMapping("registLocation")
	public String registLoction(Model model) {
		return "map/registLocation";
	}
	
	// 친구 찾기 버튼 구현 페이지 
	@GetMapping("findFriend")
	public String findFriend() {
		return "friend/findFriend";
	}
	
	
	// 친구 찾기 버튼 구현 페이지 
	@GetMapping("friendList")
	public String friendList() {
		return "friend/friendList";
	}
	

	//현재지도확인 페이지
		@GetMapping("map")
		public String viewMap(Model model) {
			model.addAttribute("apiKey",apiKey);
			try {
				model.addAttribute("list", ms.mapList());
			} catch (Exception e) {
				System.out.println("list정보 불러오기 실패");
			}
			
			return "map/map";
		}
}

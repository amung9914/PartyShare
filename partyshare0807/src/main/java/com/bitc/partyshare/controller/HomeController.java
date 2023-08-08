package com.bitc.partyshare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitc.partyshare.service.MapService;
import com.bitc.partyshare.vo.LocationVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class HomeController {

	private final MapService ms;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
	//좌표찾는 페이지
	@GetMapping("findlocation")
	public String findloction(Model model) {
		return "findlocation";
	}
	//주소등록페이지
	@GetMapping("registLocation")
	public String registLoction(Model model) {
		return "registLocation";
	}
	
	// partyDetail 페이지
	@GetMapping("partyDetail")
	public String partyDetail(String pnum,Model model) {
		model.addAttribute("pnum",pnum);
		return "partyDetail";
	}
	
	@PostMapping("findlocation")
	public String findloction(LocationVO location, Model model) {
		model.addAttribute(location);
		return "location";
	}
	

	//현재지도확인 페이지
		@GetMapping("map")
		public String viewMap(Model model) {
			try {
				model.addAttribute("list", ms.mapList());
			} catch (Exception e) {
				System.out.println("list정보 불러오기 실패");
			}
			return "map";
		}
}

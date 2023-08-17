package com.bitc.map.controller;

import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.map.service.MapService;
import com.bitc.map.vo.MapVO;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("/location")
@RequiredArgsConstructor
public class MapController {
	
	private final MapService ms;
	
	// test용 지도 추가 
	@PostMapping("")
	public String addLocation(MapVO map, Model model) {
		
		
		System.out.println("mapVO:"+ map);
		
		String result = null;
		try {
			result = ms.addLocation(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	// 지도에 마커를 표시합니다.
	//location/{pnum}
	@GetMapping("/{pnum}")
	public Map<String, String> nameTag(
			@PathVariable(name="pnum") int pnum ){
		Map<String, String> nameTag = ms.getNameTag(pnum);
		
		return nameTag; 
	}
}

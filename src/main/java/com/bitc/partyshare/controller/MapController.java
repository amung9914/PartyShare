package com.bitc.partyshare.controller;

import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.partyshare.service.MapService;
import com.bitc.partyshare.vo.MapVO;

import lombok.RequiredArgsConstructor;


@RestController
@RequestMapping("/location")
@RequiredArgsConstructor
public class MapController {
	
	private final MapService ms;
	
	
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
	//location/{pnum}
	@GetMapping("/{pnum}")
	public Map<String, String> nameTag(
			@PathVariable(name="pnum") int pnum ){
		Map<String, String> nameTag = ms.getNameTag(pnum);
		
		return nameTag; 
	}
}

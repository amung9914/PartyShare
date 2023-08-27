package com.bitc.search.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitc.party.vo.PartyVO;
import com.bitc.search.service.SearchService;
import com.bitc.search.util.CalendarSearch;
import com.bitc.search.util.MakeQuery;
import com.bitc.search.vo.descriptionVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SearchController {
	@Qualifier("CalendarSearch")
	private final CalendarSearch calendar;
	@Qualifier("ss")
	private final SearchService ss;
	private final MakeQuery mq;
	// init으로 getMapping 3개 함수를 모두 호출함
	//1
	@PostMapping("search/printDescription") // 최초에 프린트
	public ResponseEntity<List<descriptionVO>> description(int page){
		ResponseEntity<List<descriptionVO>> entity = null;
		System.out.println("pageNum =" + page);
		try {
			List<descriptionVO> list = ss.description(page);
//			System.out.println(list);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>(list,header,HttpStatus.OK);
		} catch (Exception e) {
//			System.out.println("?");
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(header,HttpStatus.BAD_REQUEST);
		}
//		System.out.println(entity);
		return entity;
	}
	
	
	@PostMapping("search/getSearchContents")
	
	public ResponseEntity<Object> getSearchContents(
		String targetContents) {
		System.out.println(targetContents + "< 출력");
		Object contents = null;
		ResponseEntity<Object> entity = null;
		try {
			
			contents = ss.printContents(targetContents); 
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<Object>(contents,HttpStatus.OK);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(e.getMessage(),header,HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
        return entity; // ajax dataType = "text",
	}
	
	
	@GetMapping("search/querySearch")
	public ResponseEntity<List<PartyVO>> querySearch(
			String resultQuery
			){
		ResponseEntity<List<PartyVO>> entity = null;
//		System.out.println(resultQuery);
		
		try {
			List<PartyVO> list = ss.partySearch(mq.addStirng(resultQuery));
			//System.out.println(list);
			entity = new ResponseEntity<>(list,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
//		System.out.println("partyVO LIST :"+ entity);
		return entity;
	}
	//2
	@GetMapping("search/count")
	@ResponseBody
	public int countDesc() {
		int count = 0;
		try {
			count =
			ss.countPartyDescription();
		} catch (Exception e) {
			System.out.println("이상하다");
		}
		return count;
	}
	

		
	
		
	
	
	
}

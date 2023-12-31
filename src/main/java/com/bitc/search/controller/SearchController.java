package com.bitc.search.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitc.common.utils.Criteria;
import com.bitc.member.vo.MemberVO;
import com.bitc.party.service.CreatePartyService;
import com.bitc.party.vo.PartyVO;
import com.bitc.search.service.SearchService;
import com.bitc.search.util.MakeQuery;
import com.bitc.search.vo.descriptionVO;
import com.bitc.wishlist.vo.WishlistVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SearchController {
	@Qualifier("ss")
	private final SearchService ss;
	private final MakeQuery mq;
	private final CreatePartyService ps;
	
	@PostMapping("search/printDescription") // 최초에 프린트
	public ResponseEntity<List<descriptionVO>> description(Criteria cri,int descPage){
		ResponseEntity<List<descriptionVO>> entity = null;
		cri.setPage(descPage);
		try {
			List<descriptionVO> list = ss.description(cri);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>(list,header,HttpStatus.OK);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(header,HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	@GetMapping("search/getSearchContents")
	
	public ResponseEntity<Object> getSearchContents(
		String targetContents) {
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
        return entity; 
	}
	
	
	@GetMapping("search/querySearch/{page}")
	public ResponseEntity<Map<String, Object>> querySearch(
			String resultQuery,
			@PathVariable(name="page") int page,
			Criteria cri,
			HttpSession session
			){
		
		MemberVO m = (MemberVO) session.getAttribute("loginMember");
		Map<String, Object> map = new HashMap<>();
		if(m != null) {
			int mnum = m.getMnum();
			List<WishlistVO> wishlist = null;
			wishlist = ps.getWishlist(mnum);
			map.put("wishlist", wishlist);
		}
		
			cri.setPage(page);
			cri.setPerPageNum(20);
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			List<PartyVO> list = ss.partySearch(mq.addStirng(resultQuery, cri));
			map.put("partyList", list);
			entity = new ResponseEntity<>(map,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
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
		}
		return count;
	}
	

		
	
		
	
	
	
}

package com.bitc.partyshare.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.partyshare.service.FriendService;
import com.bitc.partyshare.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/friend")
@RequiredArgsConstructor
public class FriendController {

	private final FriendService fs;

	/**
	 * 아이디로 사용자 검색
	 */
	
	/**
	 * 닉네임으로 사용자 검색
	 */
	
	
	/**
	 * 아이디로 사용자 검색
	 * 
	 * @param target
	 * @return
	 */
	/*
	 * @GetMapping("searchId/mid/{target}") public MemberVO searchId(
	 * 
	 * @PathVariable(name="target") String target ) throws Exception{
	 * 
	 * System.out.println("이것은mid입니다."); MemberVO vo = fs.searchId(target); if(vo ==
	 * null) { vo = new MemberVO(); vo.setMnum(-1); } return vo; }
	 * 
	 *//**
		 * 닉네임으로 사용자 검색
		 * 
		 * @param target
		 * @return
		 *//*
			 * @GetMapping("searchId/mnick/{target}") public MemberVO searchNick(
			 * 
			 * @PathVariable(name="target") String target ) throws Exception{
			 * System.out.println("이것은mnick입니다."); MemberVO vo = fs.searchNick(target);
			 * if(vo == null) { vo = new MemberVO(); vo.setMnum(-1); } return vo; }
			 */
}

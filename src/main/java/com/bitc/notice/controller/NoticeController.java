package com.bitc.notice.controller;

import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.bitc.member.vo.MemberVO;
import com.bitc.notice.provider.NoticeProvider;
import com.bitc.notice.service.NoticeService;
import com.bitc.notice.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NoticeController {
		
	private final NoticeService ns; 
	
	/*
	@PostMapping("num")
	public ResponseEntity<String> addNotice(NoticeVO vo) {
		ResponseEntity<String> entity = null;
		String message = "";
		System.out.println("controller에서 VO를 받는지 보자 form으로 온다"  +vo);
		try {
			ns.addNotice(vo);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>("성공했어요" ,header, HttpStatus.OK);
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>("아 씨발",header , HttpStatus.BAD_REQUEST );
		}
		return entity;
	}
	*/
	
	@PostMapping("notice/readPost")
	public ResponseEntity<String> readPost(int noticeNum){
		ResponseEntity<String> entity = null; 
		try {
			ns.readPost(noticeNum);
			entity = new ResponseEntity<String>("됐다" , HttpStatus.OK);
			HttpHeaders header = new HttpHeaders(); 
			header.setContentType(MediaType.TEXT_PLAIN);
			System.out.println("readPost DAO clear");
		} catch (Exception e) {
			entity = new ResponseEntity<String>("ㄴㄴ" , HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		return entity;
	}
	
	@GetMapping("/notice/receivePost") 
	 public ResponseEntity<List<NoticeVO>> receivePost(String mId){
		 ResponseEntity<List<NoticeVO>> entity = null;
//		 System.out.println(mId);
		 try {
			List<NoticeVO> list = ns.myNotice(mId);
	//		System.out.println(list +"시간확인");
			entity = new ResponseEntity<List<NoticeVO>>(list,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<NoticeVO>>(HttpStatus.BAD_REQUEST);
		}
	//	 System.out.println(entity);
		 return entity;
	 }
	
 	@PostMapping("/notice/sendPost")
 	public ResponseEntity<String> sendPost(NoticeVO notice){
 		ResponseEntity<String> entity = null; 
 		System.out.println(notice +"sendPost에서 발신");
 		NoticeProvider ntp = new NoticeProvider();
 		
 		try {
			List<MemberVO> list = ns.currentMember();
			ntp.insertPostAll(list, notice);
			System.out.println("controller sendPost출력" + list);
			ns.sendPost(list, notice);
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>("발신 성공",header,HttpStatus.OK);
			System.out.println("수행완료");
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
 		
 		System.out.println(entity);
 		return entity;
 	}
	
	
}

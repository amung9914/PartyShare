package com.bitc.notice.controller;

import java.util.List;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	
	@PostMapping("notice/readPost")
	public ResponseEntity<String> readPost(int noticeNum , String mid){
		ResponseEntity<String> entity = null; 
		try {
			ns.readPost(noticeNum,mid);
			entity = new ResponseEntity<String>("됐다" , HttpStatus.OK);
			HttpHeaders header = new HttpHeaders(); 
			header.setContentType(MediaType.TEXT_PLAIN);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>("처리하지 못함" , HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	@GetMapping("/notice/receivePost") 
	 public ResponseEntity<List<NoticeVO>> receivePost(String mid){
		 ResponseEntity<List<NoticeVO>> entity = null;
		 try {
			List<NoticeVO> list = ns.myNotice(mid);
			
			entity = new ResponseEntity<List<NoticeVO>>(list,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<NoticeVO>>(HttpStatus.BAD_REQUEST);
		}
		 return entity;
	 }
	
 	@PostMapping("/admin/sendPost")
 	public ResponseEntity<String> sendPost(NoticeVO notice){
 		ResponseEntity<String> entity = null; 
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
 		
 		return entity;
 	}
 	
 	@PostMapping("/notice/bonPostList")
	public ResponseEntity<List<NoticeVO>> bonPostList(String mid){
 		ResponseEntity<List<NoticeVO>> entity = null; 
 		
 		try {
			List<NoticeVO> list = ns.bonPostList(mid);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>(list,header,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
 		return entity;
 	}
 	
 	@PostMapping("/notice/deletePost/{no}")
	public ResponseEntity<String> deletePost(@PathVariable(name="no")int no, String mid){
 		ResponseEntity<String> entity = null; 
 		String message = ""; 
 		try {
			ns.deletePost(no,mid);
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			message	= "삭제되었습니다. 삭제한 알림 번호:" +no;
			entity = new ResponseEntity<>(message,header,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			message	= "ㄴㄴㄴ.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(message,header,HttpStatus.BAD_REQUEST);
		}
 		return entity;
 	}
	
	
}

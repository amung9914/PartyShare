package com.bitc.board.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.bitc.board.service.BoardService;

import lombok.RequiredArgsConstructor;

@Controller("bc")
@RequiredArgsConstructor
public class BoardController {
	private final BoardService bs;
	
	@PostMapping("/board/blindPartyBoard")
	public ResponseEntity<String> blindBoard(int bno){
		ResponseEntity<String> entity = null;
		String message = "";
		try {
			bs.blindPartyBoard(bno);
			message ="성공적으로 처리되었습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
		} catch (Exception e) {
			message ="오류가 발생했습니다.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		
		return entity;
	}
	
	@PostMapping("/board/blindPartyComment")
	public ResponseEntity<String> blindComment(int cno){
		ResponseEntity<String> entity = null;
		String message = "";
		try {
			bs.blindPartyComment(cno);
			message ="성공적으로 처리되었습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
		} catch (Exception e) {
			message ="오류가 발생했습니다.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		
		return entity;
	}
	
	
}

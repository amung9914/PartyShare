package com.bitc.board.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.bitc.board.service.BoardService;
import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;

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
			PartyBoardVO vo = bs.partyBoard(bno);
			if(vo.getShowboard().equals("N")) {
				message = "이미 블라인드 처리된 게시글입니다.";
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}else{
			bs.blindPartyBoard(bno);
			message ="성공적으로 처리되었습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}
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
			PartyCommentVO vo = bs.partyComment(cno);
			if(vo.getShowBoard().equals("N")) {
				message = "이미 블라인드 처리된 게시글입니다.";
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}else {
			bs.blindPartyComment(cno);
			message ="성공적으로 처리되었습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}
		} catch (Exception e) {
			message ="오류가 발생했습니다.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		
		return entity;
	}
	
	//blindFreeBoard
	
	@PostMapping("/board/blindFreeBoard")
	public ResponseEntity<String> blindFreeBoard(int bno){
		ResponseEntity<String> entity = null;
		String message = "";
		
		try {
			
			FreeBoardVO vo = bs.freeBoard(bno);
			if(vo.getShowBoard().equals("N")) {
				message = "이미 블라인드 처리된 게시글입니다.";
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}else {
			bs.blindBoard(bno);
			message ="성공적으로 처리되었습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}
		} catch (Exception e) {
			message ="오류가 발생했습니다.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(message,header,HttpStatus.BAD_REQUEST);
		}
		System.out.println(entity);
		
		return entity;
	}
	
	//blindBoardComment
	@PostMapping("/board/blindBoardComment")
	public ResponseEntity<String> blindBoardComment(int cno){
		ResponseEntity<String> entity = null;
		String message = "";
		try {
			FreeBoardCommentVO vo = bs.freeBoardComment(cno);
			if(vo.getShowBoard().equals("N")) {
				message = "이미 블라인드 처리된 게시글입니다.";
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<String>(message,header,HttpStatus.OK);
			}
			bs.blindComment(cno);
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

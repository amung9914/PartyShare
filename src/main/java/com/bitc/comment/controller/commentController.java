package com.bitc.comment.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitc.comment.service.commentService;
import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/comment/*")
@RequiredArgsConstructor
public class commentController {
	
	private final commentService cs;

	@PostMapping("comments")
	public ResponseEntity<String> addComment(@RequestBody FreeBoardCommentVO vo){
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
	
		try {
			String message = cs.addComment(vo);
			// 필수 값은 상태 코드
			entity = new ResponseEntity<>(message, headers, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	@GetMapping("comments/{bno}/{page}")
	@ResponseBody
	public Map<String, Object> listPageComment(
			@PathVariable(name="bno") int bno,
			@PathVariable(name="page") int page) {
		Map<String, Object> map = new HashMap<>();
		if(page > 0) {
			Criteria cri = new Criteria(page, 5);
			List<FreeBoardCommentVO> list;
			PageMaker cpm;
			try {
				list = cs.commentListPage(cri, bno);
				cpm = cs.getCommentPageMaker(cri, bno);
				map.put("list", list);
				map.put("cpm", cpm);
			} catch (Exception e) {
				System.out.println("listPageComment하다가 오류났거나 게시물에 댓글이 없어요.");
			}
		}
		return map;
	}
	
	@PatchMapping("comments/{cno}")
	public ResponseEntity<String> updateComment(
			@PathVariable(name="cno") int cno,
			@RequestBody FreeBoardCommentVO vo) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		vo.setCno(cno);
		String message = null;
		try {
			message = cs.updateComment(vo);
			entity = new ResponseEntity<>(message, headers, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	@DeleteMapping("comments/{cno}")
	public ResponseEntity<String> deleteComment(@PathVariable(name="cno") int cno) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
	
		try {
			String message = cs.deleteComment(cno);
			entity = new ResponseEntity<>(message, headers, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(), headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
}

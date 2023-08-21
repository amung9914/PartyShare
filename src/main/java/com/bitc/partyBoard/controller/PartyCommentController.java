package com.bitc.partyBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.partyBoard.service.PartyCommentService;
import com.bitc.partyBoard.vo.PartyCommentDTO;
import com.bitc.partyBoard.vo.PartyCommentVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/partyBoard/comments")
@RequiredArgsConstructor
public class PartyCommentController {

	private final PartyCommentService ps;
	
	// 페이징 처리된 게시글 목록
	@GetMapping("/{pnum}/{bno}/{page}")
	public Map<String,Object> list(
			// data == Map
			// {'list':{}, 'pm' : {}}
			@PathVariable(name="pnum") int pnum,
			@PathVariable(name="bno") int bno,
			@PathVariable(name="page") int page
			)throws Exception{
		Map<String,Object> map = new HashMap<>();
		Criteria cri = new Criteria(page,5);
		PartyCommentDTO dto = new PartyCommentDTO();
		dto.setBno(bno);
		dto.setPnum(pnum);
		dto.setCri(cri);
		List<PartyCommentVO> list = ps.listPage(dto);
		PageMaker pm = ps.getPageMaker(dto);
		map.put("pm",pm);
		map.put("list", list);
		return map;
	}
	
	
	@PostMapping("") // comments 
	public ResponseEntity<String> addComment(PartyCommentVO vo) {
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
	
		try {
			String message  = ps.insert(vo); //서비스에 전달함 / message는 성공여부
			entity = new ResponseEntity<>(message,headers,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(e.getMessage(),
					headers,
					HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
}

package com.bitc.partyBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bitc.partyBoard.service.PartyBoardService;
import com.bitc.partyBoard.service.PartyCommentService;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;
import com.bitc.partyBoard.vo.PartyReportVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/partyBoard/*")
@RequiredArgsConstructor
public class PartyReposrtController {

	private final PartyBoardService bs;
	private final PartyCommentService cs;
	
	/**
	 * 게시글 신고하기 페이지 
	 */
	@GetMapping("report")
	public String reportPage(PartyBoardVO board,Model model) throws Exception {
		model.addAttribute("board",bs.read(board));
		return "partyBoard/report";
	}
	
	/**
	 * 게시글 신고 처리 페이지 
	 */
	@PostMapping("report")
	public String report(PartyReportVO vo,Model model) throws Exception {
		String message = bs.report(vo);
		model.addAttribute("message",message);
		return "partyBoard/reportResult";
	}
	
	/**
	 * 댓글 신고하기 페이지 
	 */
	@GetMapping("/comments/report")
	public String reportPage(PartyCommentVO vo,Model model) throws Exception {
		model.addAttribute("comment",cs.read(vo));
		return "partyBoard/reportComment";
	}
	/**
	 * 댓글 신고 처리 
	 */
	@PostMapping("/comments/report")
	public String reportPage(PartyReportVO vo,Model model) throws Exception {
		String message = cs.report(vo);
		model.addAttribute("message",message);
		return "partyBoard/reportResult";
	}
}

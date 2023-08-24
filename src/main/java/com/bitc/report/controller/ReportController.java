package com.bitc.report.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitc.board.service.BoardService;
import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.member.vo.MemberVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;
import com.bitc.report.service.ReportService;
import com.bitc.report.vo.PbReportVO;
import com.bitc.report.vo.ReportVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReportController {
	
	private final ReportService rs;
	private final BoardService bs;
	
	@GetMapping("report/reportList")
 	@ResponseBody
 	public ResponseEntity<List<ReportVO>> reportList(Criteria cri, PageMaker pm){
 		ResponseEntity<List<ReportVO>> entity = null;
 		try {
			List<ReportVO> list = rs.reportList(cri, pm);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON);
			entity = new ResponseEntity<>(list,header,HttpStatus.OK);
			
		} catch (Exception e) {
			HttpHeaders header = new HttpHeaders();
			header.setContentType(MediaType.APPLICATION_JSON); //encode
			entity = new ResponseEntity<>(header,HttpStatus.BAD_REQUEST);
		}
 		System.out.println(entity);
 		return entity;
 	}			// returnType = list<ReportVO>
	
	 @PostMapping( //value = 
			 "report/report" 
			// produces = "text/plain; charset=UTF-8"
			 )
	public ResponseEntity<String> report(
		//	@PathVariable(name="bno" , required = false) int bno
		//	,@PathVariable(name="cno" ,required = false) int cno
		//	,@PathVariable(name="pNum" , required = false) int pNum
		//	,
			ReportVO report , MemberVO vo) {
		 
		ResponseEntity<String> entity = null;
		String result ="";
		/*
			if(bno != 0 && cno == 0) {
				//board
			}else if(bno == 0) {
				//comment mId , bno , cno 
			}else {
				//member
			}
			*/
		
			System.out.println(report);
		try {
			String date = rs.makeStringDate();
			//report.setDate(date); 
			List<ReportVO> list = rs.reportInMonth(report);
			System.out.println("m30리스트: " + list);
			
			if(list.size() > 0) {
				result = "같은 유저는 한 달에 한 번만 신고 가능합니다.";
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<String>(result,header,HttpStatus.OK);
				return entity;
			}
			
			rs.addReportCnt(report.getToMid());
			rs.addReport(report);
			int a = rs.cntOut();
			System.out.println(a +"< 밴 되면 1 ");
			result = "신고가 접수되었습니다.";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<String>(result,header,HttpStatus.OK);
		}catch (Exception e){
			result = "페이지에 오류가 있습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
		    entity = new ResponseEntity<String>(result, header, HttpStatus.BAD_REQUEST);
		    //                              e.getM -> result
		}
		
	return entity;	
	}
	 
			 @SuppressWarnings("deprecation")
			@PostMapping(value = "/report/reportReview", 
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public ResponseEntity<List<ReportVO>> report(
			MemberVO fromMid) {
		// System.out.println(fromMid +" < 전달");
		ResponseEntity<List<ReportVO>> entity = null;
		List<ReportVO> list =null;
		String errorMessage = "";
		//System.out.println("왔나?");
		try {
			
			list = rs.reportReview(fromMid);
			entity = new ResponseEntity<>(list,HttpStatus.OK);
			//System.out.println("tryENd");
		}catch (Exception e){
			errorMessage = "페이지에 오류가 있습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		System.out.println(errorMessage);
		System.out.println(entity);
			return entity;		
		}	
			 
	 	@PostMapping("report/reportDetail/{no}")
	 	public ResponseEntity<ReportVO> reportDetail (
	 			@PathVariable(name="no") int no){
	 		ResponseEntity<ReportVO> entity = null;
	 		
	 		try {
				ReportVO vo = rs.selectReport(no);
				entity = new ResponseEntity<ReportVO>(vo,HttpStatus.OK);
				System.out.println("try detail end");
			} catch (Exception e) {
				System.out.println();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity + "from reportDetail");
	 		return entity;
	 	}
	 	
	 	
	 	@PostMapping("report/reportedBoard")
	 	public ResponseEntity<List<ReportVO>> reportedBoard(Criteria cri , Model model){
	 		ResponseEntity<List<ReportVO>> entity = null;
	 		
	 		try {
				List<ReportVO> list = rs.reportedBoard(cri);
				PageMaker pm = rs.getPageMaker(cri);
				HttpHeaders header = new HttpHeaders();
				header.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<List<ReportVO>>(list,header,HttpStatus.OK);
				model.addAttribute("pm",pm);
			} catch (Exception e) {
				entity = new ResponseEntity<List<ReportVO>>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	@PostMapping("report/reportedPartyBoard")
	 	public ResponseEntity<List<PbReportVO>> reportedPartyBoard(){
	 		 ResponseEntity<List<PbReportVO>> entity =null;
	 		try {
				List<PbReportVO> list = rs.reportedPartyBoard();
				//PageMaker pm = rs.getPageMaker(cri);
				HttpHeaders header = new HttpHeaders();
				header.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<List<PbReportVO>>(list,header,HttpStatus.OK);
			//	model.addAttribute("pm",pm);
			} catch (Exception e) {
				entity = new ResponseEntity<List<PbReportVO>>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	@PostMapping("report/PbReportBoard/{no}")
	 	public ResponseEntity<PartyBoardVO> PbReportBoard(
	 			@PathVariable(name="no") int no
	 			){
	 		ResponseEntity<PartyBoardVO> entity = null;
	 		// no를 가지고 partyBoard반환 
	 		System.out.println("PbReportBoard/{no}" + no);
	 		try {
				PartyBoardVO vo = bs.partyBoard(no);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(vo,hd,HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	
	 	@PostMapping("report/PbReportComment/{no}")
	 	public ResponseEntity<PartyCommentVO> PbReportComment(
	 			@PathVariable(name="no") int no
	 			){
	 		ResponseEntity<PartyCommentVO> entity = null;
	 		
	 		try {
				PartyCommentVO vo = bs.partyComment(no);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(vo,hd,HttpStatus.OK);
			} catch (Exception e) {
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<>(header,HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	@PostMapping("report/PbReportOriginal/{no}")
	 	public ResponseEntity<PartyBoardVO> PbReportOriginal(
	 			@PathVariable(name="no") int no){
ResponseEntity<PartyBoardVO> entity = null;
	 		
	 		try {
	 			PartyBoardVO vo = bs.originalPartyBoard(no);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(vo,hd,HttpStatus.OK);
			} catch (Exception e) {
				HttpHeaders header = new HttpHeaders();
				header.add("Content-Type","text/plain;charset=utf-8");
				entity = new ResponseEntity<>(header,HttpStatus.BAD_REQUEST);
			}
	 		System.out.println("original추출:" +entity);
	 		return entity;
	 	}
			 
			 
}

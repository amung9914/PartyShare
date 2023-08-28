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

import com.bitc.admin.service.AdminService;
import com.bitc.board.service.BoardService;
import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.freeboard.vo.FreeBoardVO;
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
	private final AdminService as;
	
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
			 )
	public ResponseEntity<String> report(
	
			ReportVO report , MemberVO vo) {
		 
		ResponseEntity<String> entity = null;
		String result ="";
	
			System.out.println(report);
		try {
			String date = rs.makeStringDate();
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
		}
		
	return entity;	
	}
	 
			 @SuppressWarnings("deprecation")
			@PostMapping(value = "/report/reportReview", 
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public ResponseEntity<List<ReportVO>> report(
			MemberVO fromMid) {
		ResponseEntity<List<ReportVO>> entity = null;
		List<ReportVO> list =null;
		String errorMessage = "";
		try {
			list = rs.reportReview(fromMid);
			entity = new ResponseEntity<>(list,HttpStatus.OK);
		}catch (Exception e){
			errorMessage = "페이지에 오류가 있습니다";
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type","text/plain;charset=utf-8");
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
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
	 	
	 	
	 	//freeboard화
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
	 	
	 	
	 	//freeboard화
	 	
	 	
	 	@PostMapping("report/reportedPartyBoard")
	 	public ResponseEntity<List<PbReportVO>> reportedPartyBoard(){
	 		 ResponseEntity<List<PbReportVO>> entity =null;
	 		try {
				List<PbReportVO> list = rs.reportedPartyBoard();
				HttpHeaders header = new HttpHeaders();
				header.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<List<PbReportVO>>(list,header,HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<List<PbReportVO>>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	@PostMapping("report/boardReportOriginal/{no}")
	 	public ResponseEntity<FreeBoardVO> boardReportOriginal(
	 			@PathVariable(name="no") int no		// cno임
	 			){
	 		ResponseEntity<FreeBoardVO> entity = null;
	 		// no를 가지고 partyBoard반환 
	 		System.out.println("boardReportOriginal/{no}" + no);
	 		try {
	 			FreeBoardVO vo = bs.originalBoard(no);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(vo,hd,HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	@PostMapping("report/boardReportBoard/{no}")
	 	public ResponseEntity<FreeBoardVO> boardReportBoard(
	 			@PathVariable(name="no") int no
	 			){
	 		ResponseEntity<FreeBoardVO> entity = null;
	 		System.out.println("freeReportBoard/{no}" + no);
	 		try {
	 			FreeBoardVO vo = bs.freeBoard(no);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(vo,hd,HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
	 		System.out.println(entity);
	 		return entity;
	 	}
	 	
	 	
	 	@PostMapping("report/boardReportComment/{no}")
	 	public ResponseEntity<FreeBoardCommentVO> boardReportComment(
	 			@PathVariable(name="no") int no
	 			){
	 		ResponseEntity<FreeBoardCommentVO> entity = null;
	 		
	 		try {
	 			FreeBoardCommentVO vo = bs.freeBoardComment(no);
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
	 	
	 	@PostMapping("report/searchId")
	 	public ResponseEntity<List<MemberVO>> searchId (String mnick){
	 		ResponseEntity<List<MemberVO>> entity = null; 
	 		
	 		try {
				List<MemberVO> list = as.memberNick(mnick);
				HttpHeaders hd = new HttpHeaders();
				hd.setContentType(MediaType.APPLICATION_JSON);
				entity = new ResponseEntity<>(list,hd,HttpStatus.OK);
			} catch (Exception e) {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
				System.out.println("searchID 망함");
			}
	 		System.out.println(entity);
	 		
	 		return entity;
	 	}
	 	
	 	@GetMapping("report/admin_blackList")
	 	public String blackList() {
	 		return "admin/admin_blacklist";
	 	}
	 	
	 
			 
			 
}

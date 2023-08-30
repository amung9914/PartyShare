package com.bitc.freeboard.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bitc.common.utils.Criteria;
import com.bitc.common.utils.PageMaker;
import com.bitc.freeboard.service.freeBoardService;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.member.vo.MemberVO;
import com.bitc.report.vo.ReportVO;

import lombok.RequiredArgsConstructor;

@Controller
/* @RequestMapping("user/freeBoard/*") */
@RequiredArgsConstructor
public class freeBoardController {
	
	private final freeBoardService fs;
	
	@GetMapping("freeBoard/freeBoard")
	public void freeBoard(HttpServletRequest request, Criteria cri, Model model) {
		try {
			String type = request.getParameter("type");
			String keyword = request.getParameter("keyword");
			
			FreeBoardVO vo = new FreeBoardVO();
			vo.setType(type);
			vo.setKeyword(keyword);
			
			List<FreeBoardVO> list = null;
			List<FreeBoardVO> noticeList = null;
			
			noticeList = fs.readFreeBoardNotice();
			model.addAttribute("FreeBoardNotice", noticeList);
			
			if(vo.getType() == null) {
				list = fs.readFreeBoard(cri);
			}else {
				list = fs.getSearchList(cri, vo);
			}
			model.addAttribute("FreeBoard", list);
			
			PageMaker pm = fs.getPageMaker(cri, vo);
			model.addAttribute("pm", pm);
		} catch (Exception e) {
			System.out.println("freeBoard하다가 오류났어요.");
		}
	}
	
	@GetMapping("user/freeBoard/freeBoardWrite")
	public String freeBoardWrite() {
		return "/freeBoard/freeBoardWrite";
	}
	
	@PostMapping("user/freeBoard/freeBoardWrite")
	public String freeBoardWrite(FreeBoardVO vo) {
		
		System.out.println("write한 vo는" + vo);
		
		try {
			fs.freeBoardUpload(vo);
		} catch (Exception e) {
			System.out.println("freeBoardWrite하다가 오류났어요.");
		}
		
		return "redirect:/freeBoard/freeBoard?page=1";
	}
	
	@GetMapping("freeBoard/freeBoardRead")
	public String freeBoardRead(
			@ModelAttribute("cri") Criteria cri,
			HttpSession session, int bno, Model model)  {
		try {
			// 조회수 증가
			fs.updateFreeBoardCnt(session, bno);
			// 상세보기 요청 게시글 정보
			FreeBoardVO vo = fs.readFreeBoardDetail(bno);
			model.addAttribute("freeBoardVO", vo);
		} catch (Exception e) {
			System.out.println("freeBoardRead하다가 오류났어요.");
		}
		return "freeBoard/freeBoardRead";
	}
	
	@GetMapping("user/freeBoard/freeBoardModify")
	public String freeBoardModify(int bno, Model model, Criteria cri) {
		try {
			FreeBoardVO vo = fs.readFreeBoardDetail(bno);
			model.addAttribute("freeBoardVO", vo);
		} catch (Exception e) {
			System.out.println("freeBoardModify하다가 오류났어요.");
		}
		
		return "/freeBoard/freeBoardModify";
	}
	
	@PostMapping("user/freeBoard/freeBoardModify")
	public String freeBoardModify(
			Criteria cri,
			RedirectAttributes rttr,
			FreeBoardVO vo) {
		String result = null;
		try {
			result = fs.freeBoardModify(vo);
		} catch (Exception e) {
			System.out.println("freeBoardModify하다가 오류났어요.");
		}
		// 이동한 다음 페이지에 Model을 실어준다.
		rttr.addFlashAttribute("result", result);
		rttr.addFlashAttribute("cri", cri);
		// get 방식으로 파라미터를 넣어준다.
		rttr.addAttribute("bno", vo.getBno());
		return "redirect:/freeBoard/freeBoardRead"; // ?bno=" + vo.getBno();
	}
	
	@GetMapping("user/freeBoard/freeBoardRemove")
	public String freeBoardRemove(int bno, Criteria cri, RedirectAttributes rttr, HttpServletRequest request, HttpSession session) {
		String result = null;
		
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		String freeBoardMid = request.getParameter("mid");
		
		// 관리자 계정은 모든 게시글 삭제 가능
		if(loginMember.getMid().equals("admin")) {
			try {
				result = fs.freeBoardRemove(bno);
			} catch (Exception e) {
				System.out.println("freeBoardRemove하다가 오류났어요.");
			}
			rttr.addFlashAttribute("result", result);
			rttr.addAttribute("page", cri.getPage());
			rttr.addAttribute("perPageNum", cri.getPerPageNum());
			return "redirect:/freeBoard/freeBoard";
		}
		
		
		// 작성자 본인이 아닐 경우 게시글 삭제 불가
		if(loginMember == null || !freeBoardMid.equals(loginMember.getMid())) {
			result = "작성자만 삭제할 수 있습니다.";
			rttr.addFlashAttribute("result", result);
			return "redirect:/freeBoard/freeBoardRead?bno=" + bno;
		} else {
			try {
				result = fs.freeBoardRemove(bno);
			} catch (Exception e) {
				System.out.println("freeBoardRemove하다가 오류났어요.");
			}
		}
		 rttr.addFlashAttribute("result", result);
		 rttr.addAttribute("page", cri.getPage());
		 rttr.addAttribute("perPageNum", cri.getPerPageNum());
		 return "redirect:/freeBoard/freeBoard";
	}
	
	@GetMapping("user/freeBoard/reportPopup")
	public String reportPopup(
			@RequestParam(name="mnick") String mnick,
			Model model
			) {
		
		model.addAttribute("mnick", mnick);
		
		return "freeBoard/reportPopup";
	}
	
	@PostMapping("user/freeBoard/reportPopup")
	public String reportPopup(
			String mnick,
			String fromMid,
			String toMid,
			String category,
			String context,
			String bno,
			String cno,
			Model model) {
		fromMid = fromMid.replace(",", "");
		toMid = toMid.replace(",", "");
		bno = bno.replace(",", "");
		cno = cno.replace(",", "");
		int nbno;
		int ncno;
		
		if(bno.equals("") || bno == null) {
			nbno = 0;
		} else {
			nbno = Integer.parseInt(bno);
		}
		
		if(cno.equals("") || cno == null) {
			ncno = 0;
		} else {
			ncno = Integer.parseInt(cno);
		}
		
		// 나중에 report 테이블에 넣을 bno, cno값 테스트용 출력(나중에 테이블에 삽입할 때 Integer.parseInt해야 함)
		System.out.println("fromMid : " + fromMid);
		System.out.println("toMid : " + toMid);
		System.out.println("category : " + category);
		System.out.println("bno : " + bno);
		System.out.println("cno : " + cno);
		
		model.addAttribute("mnick", mnick);
		
		if(category.equals("nothing")) {
			String message = "분류를 선택해주세요.";
			model.addAttribute("message", message);
			return "freeBoard/reportPopup";
		}
		
		ReportVO vo = new ReportVO();
		vo.setFromMid(fromMid);
		vo.setToMid(toMid);
		vo.setCategory(category);
		vo.setContext(context);
		vo.setBno(nbno);
		vo.setCno(ncno);
		
		try {
			String message = fs.report(vo);
			model.addAttribute("message", message);
		} catch (Exception e) {
			System.out.println("reportPopup하다가 오류났어요.");
			System.out.println(e.getMessage());
		}
		
		return "freeBoard/reportPopup";
	}
	
	@GetMapping("user/freeBoard/freeBoardReply")
	public String freeBoardReply(int bno, Model model) {
		// bno == 답변을 작성하려는 원본글 번호
		try {
			model.addAttribute("board", fs.readFreeBoardDetail(bno));
		} catch (Exception e) {
			System.out.println("freeBoardReply get하다가 오류났어요.");
		}
		return "freeBoard/freeBoardReply";
	}
	
	@PostMapping("user/freeBoard/freeBoardReply")
	public String freeBoardReply(FreeBoardVO vo) {
		// 답변글 등록
		try {
			fs.replyFreeBoard(vo);
		} catch (Exception e) {
			System.out.println("freeBoardReply post하다가 오류났어요.");
		}
		// 답변글 등록 완료 시 게시글 목록 페이지로 이동 
		return "redirect:/freeBoard/freeBoard";
	}
	
}
